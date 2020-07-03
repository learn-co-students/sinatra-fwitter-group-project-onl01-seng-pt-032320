class TweetsController < ApplicationController

    get '/tweets' do
        
        if logged_in? && current_user

            #@tweets = Tweet.find_by(:user_id => session[:user_id])
            @tweets = current_user.tweets
            erb :'tweets/tweets'
        else
            redirect "/login"
        end

    end

    get '/tweets/new' do 
        if logged_in?
            erb :'tweets/new'
        else
            redirect '/login'
        end
    end

    post '/tweets' do
        if params[:content].empty?
            redirect "/tweets/new"
        else
            tweet = Tweet.new(:content => params[:content])
            tweet.user_id = current_user.id
            tweet.save

        end
        redirect "/tweets"
    end


    get '/tweets/:id' do
        if logged_in?
            @tweet = Tweet.find_by(params[:id])
            erb :'tweets/show_tweet'
        else
            redirect to "/login"
        end
    end

    get '/tweets/:id/edit' do 

        if logged_in? && current_user
            @tweet = Tweet.find_by_id(params[:id])
            erb :'tweets/edit_tweet'
        else
            redirect '/login'
        end
    end

    patch '/tweets/:id' do 
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            @tweet.content = params[:content]
            @tweet.save
            redirect to "/tweets/#{@tweet.id}/edit"
        else
            redirect "/login"
        end
    end

    delete '/tweets/:id' do 
        @tweet = Tweet.find_by(params[:id])
        @tweet.delete
        redirect '/tweets'
    end

    
end
