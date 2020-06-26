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
        if !Helpers.is_logged_in?(session)
          redirect to '/login'
        end
        erb :"/tweets/create_tweet"
    end

    post '/tweets' do
        if !Helpers.is_logged_in?(session)
            redirect '/tweets/new'
        end 
    end

    get '/tweets/new' do 
        if Helpers.is_logged_in?(session)
            erb :new
        end 
    end 

    get '/tweets/:id' do 

    end 

end
