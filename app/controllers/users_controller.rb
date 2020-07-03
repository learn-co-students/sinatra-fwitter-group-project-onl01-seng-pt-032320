class UsersController < ApplicationController

    get '/signup' do
        if session[:user_id] == nil
            erb :'users/signup'
        else
            redirect '/tweets'
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
        ###find the user in the db, authenticate user, send them to tweets
        ###if user doesn't exist, send them to "/login"
        user = User.find_by(:username => params[:username])

            if user && user.authenticate(params[:password])
                session[:user_id] = user.id
            elsif !(user && user.authenticate(params[:password]))
                redirect "/signup"
            else
                redirect "/login"
            end
            
        redirect "/tweets"
            
    end

    
    get '/users/:slug' do
        slug = params[:slug]
        @user = User.find_by_slug(slug)
        erb :'users/show'
      end
      


    get '/logout' do
        session.clear
        redirect "/login"
    end
end
