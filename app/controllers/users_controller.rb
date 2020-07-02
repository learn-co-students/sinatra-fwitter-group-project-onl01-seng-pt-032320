class UsersController < ApplicationController

    get '/signup' do
        if session[:user_id] == nil
            erb :'users/signup'
        else
            redirect to '/tweets'
        end
    end
    
    post '/signup' do 
        user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
        
        if user.save
            session[:user_id] = user.id
            redirect "/tweets"
        else
            redirect "/signup"
        end
    end

    get '/login' do 
        if logged_in?
            redirect "/tweets"
        else
           erb :'users/login'
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

    



    get '/logout' do
        session.clear
        redirect "/login"
    end
end
