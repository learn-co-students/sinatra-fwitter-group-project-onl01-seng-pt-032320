class UsersController < ApplicationController

    get '/signup' do
        if logged_in?
            redirect "/tweets"
        else
            erb :'/users/create_user'
        end        
    end
    
    post '/signup' do
        if params.values.include?("") 
            redirect '/signup'
        else 
            user = User.create(params)
            session[:id] = user.id
            redirect '/tweets'
        end
    end
    
    get '/login' do
        if logged_in?
            redirect "/tweets"
        else
            erb :'/users/login'
        end        
    end
    
    post '/login' do
        if params.values.include?("") 
            redirect '/login'
        else 
            user = User.find_by(username: params[:username])
            if user && user.authenticate(params[:password])
                session[:id] = user.id
                redirect '/tweets'
            else
                redirect '/login'
            end
        end
    end
    
    get '/logout' do
        if logged_in?
            session.clear
            redirect '/login'
        else
            redirect '/'
        end
    end

end
