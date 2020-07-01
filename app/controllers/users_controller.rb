class UsersController < ApplicationController

    get '/signup' do
        if logged_in?
            redirect "/tweets"
        else
            erb :'/users/create_user'
        end        
    end
    
    post '/signup' do
        user = User.create(params)
        session[:id] = user.id
        redirect '/tweets'
    end
    
    get '/login' do
        if logged_in?
            redirect "/tweets"
        else
            erb :'/users/login'
        end        
    end
    
    post '/login' do
        user = User.find_by(username: [:username])
        if user && user.authenticate(params[:password])
            session[:id] = user.id
            redirect '/tweets'
        else
            redirect '/users/login'
        end
    end
    
    get '/logout' do
        session.clear
        redirect '/'
    end

end
