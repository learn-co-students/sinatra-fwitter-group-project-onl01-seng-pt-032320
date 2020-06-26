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
          redirect to "/tweets"
        end
    
        erb :"/users/login"
    end

    post '/login' do
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
          session[:User_id] = user.id
          redirect "/tweets"
        else
          redirect "/login"
        end
    end

    get '/logout' do 
        session.clear
        redirect "/"
    end 


end
