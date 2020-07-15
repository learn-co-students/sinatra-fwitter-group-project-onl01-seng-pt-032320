class UsersController < ApplicationController
    configure do
        enable :sessions
        set :session_secret, "secret"
    end

    get '/signup' do
        if !logged_in?
          erb :'users/signup'
        else
            @user == current_user
            redirect to '/tweets'
        end
      end
    
    post '/signup' do
     if params[:username] == "" || params[:email] == "" || params[:password] == ""
        redirect to 'users/signup'
    else
        @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
          session[:user_id] = @user.id
          redirect to '/tweets'
        end
      end

      get '/login' do
        if !logged_in?
            erb :'users/login'
        else
            redirect to '/tweets'
      end
     end

      post '/login' do
        @user = User.find_by(:username => params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect to '/tweets'
          else
            redirect to '/signup'
          end
        end

      get '/logout' do
        if !logged_in?
          redirect to '/'
        else
          session.clear
          redirect to "/login"
        end
      end

      get "/users/:slug" do
        @user = User.find_by_slug(params[:slug])
        erb :'tweets/tweets'
      end


            helpers do

                def current_user
                    if session[:user_id]
                      @current_user = User.find(session[:user_id])
                    end
                  end

                def logged_in?
                    !!current_user
                end

            end

end
