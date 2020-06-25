class UsersController < ApplicationController

  get '/signup' do
    if session[:user_id] == nil
      erb :'users/signup'
    else
       redirect to '/tweets'
    end
  end

  post '/signup' do
     if !(params.has_value?(""))
       user = User.create(params)
      session["user_id"] = user.id
       redirect to '/tweets'
     else
       redirect to '/signup'
   end
  end


  get '/login' do
    if session[:User_id] == nil
      erb 'users/login'
    else
      redirect "/tweets"
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:User_id] = user.id
      redirect "/tweets"
    else
      redirect 'login'
    end
  end

  get '/logout' do
    if session[:User_id] != nil
      session.clear
      redirect 'login'
    else
      redirect 'index'
    end
  end


end
