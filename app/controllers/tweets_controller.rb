class TweetsController < ApplicationController
    get "/tweets" do
        return redirect "/login" if !logged_in?
        @tweets = Tweet.all
        erb :'tweets/list'
    end

    post "/tweets" do
        return redirect "/login" if !logged_in?
        return redirect "/tweets/new" if params[:content].empty?
        Tweet.create(content: params[:content], user_id: session[:user_id])
        redirect "/tweets"
    end

    get "/tweets/new" do
        return redirect "/login" if !logged_in?
        erb :'tweets/new'
    end

    get "/tweets/:id/edit" do 
        return redirect "/login" if !logged_in?
        @tweet = Tweet.find_by_id(params[:id])
        return redirect "/tweets" if @tweet.user_id != session[:user_id]
        erb :'tweets/edit'
    end

    post "/tweets/:id/edit" do
        return redirect "/login" if !logged_in?
        return redirect "/tweets/#{params[:id]}/edit" if params[:content].empty?
        tweet = Tweet.find_by_id(params[:id])
        return redirect "/tweets" if tweet.user_id != session[:user_id]
        tweet.content = params[:content]
        tweet.save
        redirect "/tweets/#{tweet.id}"
    end

    post "/tweets/:id/delete" do
        return redirect "/login" if !logged_in?
        tweet = Tweet.find_by_id(params[:id])
        redirect "/tweets" if tweet == nil || tweet.user_id != session[:user_id]
        tweet.destroy
        redirect "/tweets"
    end

    get "/tweets/:id" do 
        return redirect "/login" if !logged_in?
        @tweet = Tweet.find_by_id(params[:id])
        erb :'tweets/show'
    end

end
