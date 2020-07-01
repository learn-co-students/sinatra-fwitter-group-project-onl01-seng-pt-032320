class TweetsController < ApplicationController

    get '/tweets' do
        @tweet = Tweet.all 
        erb :tweets
    end

    get '/tweets/new' do 

    end

    post '/tweets' do

    end

    get '/tweet/:id' do
        ##create an edit link
        ##create a delet link
    end

    get '/tweets/:id/edit' do

    end

    post '/tweets/:id' do

    end

    post '/tweets/:id/delet' do 

    end
end
