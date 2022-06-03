# These lines load Sinatra and a helper tool to reload the server
# when we have changed the file.
require "sinatra/base"
require "sinatra/reloader"

# You will want to require your data model class here
require "database_connection"
require "animals_table"
require "animal_entity"
require "properties_entity"
require "properties_table"
require "date_handler"

#require_relative "controllers/app_controller"
#require_relative "controllers/home_controller"
#require_relative "controllers/registration_controller"

class WebApplicationServer < Sinatra::Base
  # This line allows us to send HTTP Verbs like `DELETE` using forms
  use Rack::MethodOverride

  configure :development do
    # In development mode (which you will be running) this enables the tool
    # to reload the server when your code changes
    register Sinatra::Reloader

    # In development mode, connect to the development database
    db = DatabaseConnection.new("localhost", "web_application_dev")
    $global = { db: db }
  end

  configure :test do
    # In test mode, connect to the test database
    db = DatabaseConnection.new("localhost", "web_application_test")
    $global = { db: db }
  end

  def animals_table
    $global[:animals_table] ||= AnimalsTable.new($global[:db])
  end

  def makersbnb_table
    $global[:makersbnb_table] ||= PropertiesTable.new($global[:db])
  end

  # Start your server using `rackup`.
  # It will sit there waiting for requests. It isn't broken!

  # YOUR CODE GOES BELOW THIS LINE

  get "/Makersbnb" do
    erb :makersbnb_login, locals: { properties: makersbnb_table.list }
  end

  get "/Makersbnb/new_user" do
    erb :new_user
  end

  post "/Makersbnb" do
    properties_entity = PropertiesEntity.new(property_name: params[:property_name],
                                             description: params[:description],
                                             price: params[:price],
                                             availability_start: params[:availability_start],
                                             availability_end: params[:availability_end])
    makersbnb_table.add(properties_entity)
    redirect "/Makersbnb"
  end

  get "/Makersbnb/new_property" do
    erb :new_property
  end

  # EXAMPLE ROUTES

  get "/animals" do
    erb :animals_index, locals: { animals: animals_table.list }
  end

  get "/animals/new" do
    erb :animals_new
  end

  post "/animals" do
    animal = AnimalEntity.new(params[:species])
    animals_table.add(animal)
    redirect "/animals"
  end

  delete "/animals/:index" do
    animals_table.remove(params[:index].to_i)
    redirect "/animals"
  end

  get "/animals/:index/edit" do
    animal_index = params[:index].to_i
    erb :animals_edit, locals: {
                         index: animal_index,
                         animal: animals_table.get(animal_index),
                       }
  end

  patch "/animals/:index" do
    animal_index = params[:index].to_i
    animals_table.update(animal_index, params[:species])
    redirect "/animals"
  end
end
