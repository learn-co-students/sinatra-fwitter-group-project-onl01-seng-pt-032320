require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret" #For the sake of time, I decided to leave "secret" as is because implementing security wasn't important for this lab. 
  end

  get '/' do
    @user = current_user if is_logged_in?
    erb :index
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :"users/login"
    end 
end

 post '/login' do
      user = User.find_by(username: params[:username])
      if user && user.authenticate(params[:password])
          session[:user_id] = user.id
      else
          redirect '/login'
      end
      redirect '/tweets'
      
  end

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/create_user'
    end
end

post '/signup' do
    user = User.new(params)
    if user.save && user.username != "" && user.email != ""
        session[:user_id] = user.id
        redirect '/tweets'
    else
        redirect '/signup'
    end
    redirect '/tweets'
end


  get '/logout' do
    logout!
    redirect '/login'
  end

  ##Helpers

  helpers do

    
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      @user ||= User.find_by_id(session[:user_id]) if logged_in?
    end

    def logout!
      session.clear
    end 
  end

end
