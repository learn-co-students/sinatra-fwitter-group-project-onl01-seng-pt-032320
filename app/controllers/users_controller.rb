require 'pry'
class UsersController < ApplicationController

    get "/" do
        if Helpers.is_logged_in?(session)
            redirect "/tweets"
        else
            erb :'/users/index'
        end
    end

    get "/signup" do
        if Helpers.is_logged_in?(session)
            redirect "/tweets"
        end 
        erb :'/users/signup'
    end

    post "/signup" do
        if params[:username] == "" || 
            params[:email] == "" || 
            params[:password] == ""
            redirect "/signup"
        end 
      
        user = User.new(
            :username => params[:username], 
            :email => params[:email],
            :password => params[:password]) 
      
        if user.save
            session[:user_id] = user.id
			redirect "/tweets"
        else
            redirect "/signup"
        end
    end 

    get "/login" do
        if Helpers.is_logged_in?(session)
            redirect "/tweets"
        else
            erb :'/users/login'
        end
    end

    post "/login" do 
        user = User.find_by(:username => params[:username])
 
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect "/tweets"
		else
			redirect "/login"
		end
    end 

    get "/failure" do
        erb :'/users/failure'
    end

    get "/logout" do
        if Helpers.is_logged_in?(session)
            session.clear
            redirect "/login"
        else
            redirect "/"
        end
    end

end
