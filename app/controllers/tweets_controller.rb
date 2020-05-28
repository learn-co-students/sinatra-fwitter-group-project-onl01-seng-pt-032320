class TweetsController < ApplicationController

    get '/tweets' do
        if is_logged_in?
            @tweets=Tweet.all
            erb :'tweets/tweets'
        else
            redirect '/login'
        end
    end

    get '/tweets/new' do
        if is_logged_in?
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

    get '/tweets/:id/edit' do
        if session[:id] != nil
            @tweet=Tweet.find(params[:id])
            if current_user.id == @tweet.user_id
                erb :'tweets/edit'
            else
                redirect "/tweets/#{@tweet.id}"
            end
        else
            redirect '/login'
        end
    end

    get '/tweets/:id' do
        if is_logged_in?
            @tweet=Tweet.find(params[:id])
            erb :'tweets/tweets'
        else
            redirect '/login'
        end
    end

    patch '/tweets/:id/edit' do
        if params[:tweet][:content] != ""
            @tweet=Tweet.find(params[:id])
            @tweet.update(params[:tweet])
            @tweet.save
            redirect "/tweets/#{@tweet.id}"
        else
            redirect "/tweets/#{tweet.id}/edit"
        end
    end

    delete '/tweets/:id' do
        tweet = Tweet.find(params[:id])
        if tweet.user_id == current_user.id
            tweet.destroy
            redirect '/tweets'
        else
            redirect "/tweets/#{tweet.id}/edit"
        end
        
    end

end
