class TweetsController < ApplicationController

    get '/tweets' do
        if logged_in?
            @tweets = Tweet.all 
            erb :'tweets/tweets'
        else
            redirect "/login"
        end
    end

    get '/tweets/new' do 
        if logged_in?
            erb :'tweets/new'
            binding.pry
        else
            redirect "/login"
        end
    end

    post '/tweets' do
        if params[:content].empty?
            redirect '/tweets/new'
        else
            tweet = Tweet.new(:content => params[:content])
            tweet.save
            redirect '/tweets'
        end
    end

    get '/tweet/:id' do

    end

    get '/tweets/:id/edit' do
 ##create an edit link
        ##create a delet link
    end

    post '/tweets/:id' do

    end

    post '/tweets/:id/delet' do 

    end
end
