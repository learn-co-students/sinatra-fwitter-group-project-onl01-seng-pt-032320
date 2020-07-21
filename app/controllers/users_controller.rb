class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'users/create_user', locals: {message: "Please sign up before you sign in"}
    else
      redirect to '/tweets'
    end
  end
  
  get '/login' do
    erb :'users/login'
  end

end
