class UsersController < ApplicationController

    get '/signup' do
            if !logged_in?
              erb :'users/create_user'
            else
              redirect to '/tweets'
            end
    end
   
    post '/signup' do
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
          redirect to '/signup'
        else
        
         @user = User.create(username: params[:username], password: params[:password])
         session[:user_id] = @user.id
        end
         
        redirect to '/tweets'
    end

    get '/login' do
        if !logged_in?
            erb :'users/login'
          else
            redirect to '/tweets'
          end
    end

    post '/login' do
        if !logged_in?
            redirect to '/login'
        end
        redirect to "/tweets"
    end


    

end
