class UsersController < ApplicationController

    get '/signup' do 
        if !is_logged_in? 
            erb :'users/create_user' 
        else 
            redirect to '/tweets'
        end
    end 
        
    post '/signup' do
        if params.values.any?{|param| param.empty?}
            redirect to '/signup'
        else
            @user = User.create(params)
            session[:user_id] = @user.id 
            redirect to '/tweets'
        end
    end 

            
    get '/login' do 
        if is_logged_in? 
            redirect to '/tweets'
        else 
            erb :'users/login'
        end
    end 

    post '/login' do 
        @user = User.find_by(username: params[:username])
		if @user && @user.authenticate(params[:password])
			session[:user_id] = @user.id
			redirect to '/tweets'
		else 
			redirect to '/login'
		end 
    end 

    get '/users/:slug' do 
        @user = User.find_by(username: params[:slug])
        @tweets = @user.tweets
        erb :'tweets/tweets'

    end 

    get '/logout' do 
        if is_logged_in? 
            session.clear 
            redirect to '/login'
        else 
            redirect to '/'
        end 
    end 

   
end
