class UsersController < ApplicationController

    get '/signup' do
        if is_logged_in?
            redirect "/tweets"
        else
            erb :'users/signup'
        end
 
    end
    
    post '/signup' do
        if params.values.include?("")
            redirect "/signup"
        else
            user=User.create(params)
            session[:id] = user.id
        
            redirect "/tweets"
        end
    end

    get '/login' do
        if is_logged_in?
            redirect '/tweets'
        else
            erb :'users/login'
        end

    end

    post '/login' do
        if params.values.include?("")
            redirect "/login"
        end
        user = User.find_by(username: params[:username])
        if user.authenticate(params[:password])
            session[:id] = user.id
            redirect '/tweets'
        else
            redirect '/login'
        end

    end

    get '/logout' do
        if is_logged_in?
            session.clear
            redirect "/login"
        else
            redirect '/'
        end
    end

    post '/logout' do
        session.clear
        redirect "/login"
    end

    get "/users/:slug" do
        user=User.find_by(username: params[:slug])
        @tweets=user.tweets

        erb :"tweets/tweets"
      

    end


end
