class TweetsController < ApplicationController

    get '/tweets' do
        if !Helpers.logged_in?(session)
            redirect to '/login'
        end
        @tweets = Tweet.all
        @user = Helpers.current_user(session)
        erb :'tweets/tweets'
    end
end