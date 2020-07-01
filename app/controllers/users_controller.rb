class UsersController < ApplicationController

    get '/signup' do 
        ##log the user in and add user_id to sessions hash
        
    end
    
    post '/signup' do 
        user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
    end

    get '/login' do 
        ##form to log in 
    end

    post '/login' do 

    end

    get '/logout' do
        ##clears sessions hash
        if user.logged_in?
            redirect to "/tweets"
        else
            redirect to "/login"
        end
    end
end
