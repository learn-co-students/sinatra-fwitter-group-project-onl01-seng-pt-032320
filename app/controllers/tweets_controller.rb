class TweetsController < ApplicationController
    
    get '/tweets' do
        if !Helpers.is_logged_in?(session)
          redirect '/login'
        end
        @tweets = Tweet.all
        @user = Helpers.current_user(session)
        erb :"/tweets/tweets"
    end

    get '/tweets/new' do
        if Helpers.is_logged_in?(session)
            current_user
            erb :"tweets/new"
        else
            redirect '/login'
        end
    end


    post '/tweets' do
        if params[:content] != ""
            tweet=Tweet.new(params)
            tweet.user_id = session[:id]
            tweet.save
            @tweets = Tweet.all
            erb :'tweets/tweets'
        else
            redirect '/tweets/new'
        end
    end

    

    get '/tweets/:id' do 

    end 

    
end
