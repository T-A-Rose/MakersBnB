# These lines load Sinatra and a helper tool to reload the server
# when we have changed the file.
require "sinatra/base"
require "sinatra/reloader"
require "sinatra/activerecord"

# You will want to require your data model class here
require "database_connection"
require "properties_entity"
require "properties_table"
require "users_entity"
require "users_table"

#session secret
class WebApplicationServer < Sinatra::Base
  # This line allows us to send HTTP Verbs like `DELETE` using forms
  use Rack::MethodOverride

  configure :development do
    # In development mode (which you will be running) this enables the tool
    # to reload the server when your code changes
    register Sinatra::Reloader
    register Sinatra::ActiveRecordExtension
    enable :sessions

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

  # Start your server using `rackup`.
  # It will sit there waiting for requests. It isn't broken!

  # YOUR CODE GOES BELOW THIS LINE

  get "/Makersbnb" do
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
    users_table.add(users_entity)
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
      redirect "/Makersbnb/listings"
    end
  end

  get "/Makersbnb/listings" do
    erb :listings, locals: { user_id: session[:user_id],
                             properties: properties_table.list }
  end

  get "/Makersbnb/new_property" do
    erb :new_property, locals: { user_id: session[:user_id] }
  end

  post "/Makersbnb/listings" do
    properties_entity = PropertiesEntity.new(property_name: params[:property_name],
                                             description: params[:description],
                                             price: params[:price],
                                             availability_start: params[:availability_start],
                                             availability_end: params[:availability_end],
                                             user_id: session[:user_id])
    properties_table.add(properties_entity)
    redirect "/Makersbnb/listings"
  end

  get "/sign-out" do
    session.clear
    redirect "/Makersbnb"
  end
end
