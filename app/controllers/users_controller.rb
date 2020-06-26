class UsersController < ApplicationController
   
    get '/signup' do

        if Helpers.is_logged_in?(session)
         redirect to '/tweets'
       end
   
       erb :"/users/signup"
    end
   
    post '/signup' do
       user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
       if user.save && user.username != "" && user.email != ""
         session[:user_id] = user.id
         redirect to "/tweets"
       else
         redirect '/signup'
       end
       redirect to "/tweets"
    end
   
    get '/login' do
        if Helpers.is_logged_in?(session)
          redirect "/tweets"
        else
          erb :"users/login"
        end 
    end

    post '/login' do
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect "/tweets"
        else
          redirect '/login'
        end
    end

    get '/logout' do
        if Helpers.is_logged_in?(session) != nil 
          session.clear
          redirect to 'users/login'
        else
          redirect to 'index'
        end
    end


end
