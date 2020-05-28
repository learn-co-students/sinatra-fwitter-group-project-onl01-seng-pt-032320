require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :home
  end

  helpers do

    def is_logged_in?
    
      !!session[:id]
    end

    def current_user
      @user = User.find(session[:id])
    end

  end

  
end
