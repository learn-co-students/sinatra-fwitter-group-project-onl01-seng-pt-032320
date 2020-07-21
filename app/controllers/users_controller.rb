class UsersController < ApplicationController
  get "/signup" do
    return redirect "/tweets" if logged_in?
    erb :signup
  end

  post "/signup" do
    return redirect "/signup" if params[:username].empty? || params[:email].empty? || params[:password].empty?
    
    user = User.find_by(username: params[:username])
    return redirect "/signup" if user != nil
  
    user = User.create(username: params[:username], password: params[:password], email: params[:email])
    session[:user_id] = user.id
    redirect "/tweets"
  end
  
  get "/login" do
    return redirect "/tweets" if logged_in?
    erb :login
  end
  
  post "/login" do
    return redirect "/login" if params[:username].empty? || params[:password].empty?
      
    user = User.find_by(:username => params[:username])
    
    return redirect "/login" if user == nil || !user.authenticate(params[:password])
    
    session[:user_id] = user.id
    redirect "/tweets"
  end
  
  get "/logout" do
    session.clear
    redirect "/login"
  end

  get "/users/:slug" do
    @tweets = User.find_by_slug(params[:slug]).tweets
    erb :'users/show'
  end
end
