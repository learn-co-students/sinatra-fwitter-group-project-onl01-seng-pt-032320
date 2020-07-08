# frozen_string_literal: true

require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }
    use Rack::Session::Pool, expire_after: 2_592_000 # seconds
    use Rack::Protection::RemoteToken
    use Rack::Protection::SessionHijacking
    set(:auth) do
      condition do
        redirect '/login', 302 unless logged_in?
      end
    end
  end

  get '/' do
    erb :index
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :login
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    session[:user_id] = user.id if user&.authenticate(params[:password])

    redirect '/tweets'
  end

  get '/logout' do
    session.clear

    redirect '/login'
  end

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :signup
    end
  end

  post '/signup' do
    user = User.create(username: params[:username], email: params[:email], password: params[:password])

    if user.valid?
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end
end
