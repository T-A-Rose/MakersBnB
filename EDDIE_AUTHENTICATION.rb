class UserAuthApp < Sinatra::Base
  register Sinatra: ActiveRecordExtension #<-- I dont fully know what this is. I think only with this you can use sessions
  set :root, File.dirname(File.expand_path("..", __FILE__)) #<-- This sets the path to the file to link it with i think
  enable :sessions #<-- self explanatory

  def current_user
    User.find_by(id: session[:user_id]) #<-- I dont know where it gets the User class and the find_by method. I think its built in
  end
end
