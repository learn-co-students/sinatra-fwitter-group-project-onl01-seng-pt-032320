class UsersController < ApplicationController

  get '/signup' do
    redirect "/tweets" if logged_in?
    erb :'users/create_user'
  end

  post '/signup' do
    params.each_value {|v| redirect "/signup" if v.empty?}
    user = User.create(params)
    session[:user_id] = user.id
    redirect "/tweets"
  end

  get '/login' do
    redirect "/tweets" if logged_in?
    erb :'users/login'
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
		else
      redirect "/login"
    end
  end

  get '/logout' do
    session.clear if logged_in?
    redirect "/login"
  end

  get '/users/:slug' do
    erb :'users/show'
  end

end
