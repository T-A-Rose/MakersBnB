# These lines load Sinatra and a helper tool to reload the server
# when we have changed the file.
require "sinatra/base"
require "sinatra/reloader"

####AUTHENTICATION####
require "sinatra/activerecord"
######################

# You will want to require your data model class here
require "database_connection"
require "animals_table"
require "animal_entity"
require "properties_entity"
require "properties_table"
require "date_handler"
require "users_entity"
require "users_table"

#require_relative "controllers/app_controller"
#require_relative "controllers/home_controller"
#require_relative "controllers/registration_controller"
#session secret
class WebApplicationServer < Sinatra::Base
  # This line allows us to send HTTP Verbs like `DELETE` using forms
  use Rack::MethodOverride
  use Rack::Session::Pool, :expire_after => 2592000

  configure :development do
    # In development mode (which you will be running) this enables the tool
    # to reload the server when your code changes
    register Sinatra::Reloader

    ####AUTHENTICATION#####
    register Sinatra::ActiveRecordExtension
    #set :root.File.dirname(File.expand_path("..", __FILE__))
    enable :sessions
    #######################

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

  def properties_table
    $global[:properties_table] ||= PropertiesTable.new($global[:db])
  end

  def users_table
    $global[:users_table] ||= UsersTable.new($global[:db])
  end

  ####AUTHENTICATION#####
  def current_user
    User.find_by(id: session[:user_id])
  end

  #######################
  # Start your server using `rackup`.
  # It will sit there waiting for requests. It isn't broken!

  # YOUR CODE GOES BELOW THIS LINE

  get "/Makersbnb" do
    #erb :makersbnb_login, locals: { properties: makersbnb_table.list }
    erb :makersbnb
  end

  get "/Makersbnb/sessions/new" do
    erb :login
  end

  post "/Makersbnb/registrations" do
    users_entity = UsersEntity.new(username: params[:username],
                                   password: params[:password],
                                   contact: params[:contact],
                                   email: params[:email])
    ####AUTHENTICATION#### #It shouldnt get the id from here but when it logs in
    users_table.add(users_entity)
    #session[:user_id] = @user_id
    ######################
    redirect "/Makersbnb"
  end

  post "/Makersbnb/sessions" do
    user_id = users_table.get_user(
      username: params[:username],
      password: params[:password],
    )
    if user_id == false
      redirect "/Makersbnb"
    else
      session[:user_id] = user_id
      redirect "/Makersbnb/#{session[:user_id]}/listings"
    end
  end

  get "/Makersbnb/:user_id/listings" do
    erb :listings, locals: { user_id: session[:user_id],
                             properties: properties_table.list }
  end

  get "/Makersbnb/:user_id/new_property" do
    erb :new_property, locals: { user_id: session[:user_id] }
  end

  post "/Makersbnb/:user_id/listings" do #is this /makersbnb/listings or /makersbnb/:index/listings?
    #get the user_id here from the session and pass it to properties when initializing
    properties_entity = PropertiesEntity.new(property_name: params[:property_name],
                                             description: params[:description],
                                             price: params[:price],
                                             availability_start: params[:availability_start],
                                             availability_end: params[:availability_end],
                                             user_id: session[:user_id])
    properties_table.add(properties_entity)
    redirect "/Makersbnb/:user_id/listings"
  end

  get "/sign-out" do
    session.clear
    redirect "/Makersbnb"
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
