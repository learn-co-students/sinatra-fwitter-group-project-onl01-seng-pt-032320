class TweetsController < ApplicationController

  get '/tweets' do
    redirect "/login" if !logged_in?
    @tweets = Tweet.all
    erb :'tweets/tweets'
  end

  get '/tweets/new' do
    redirect "/login" if !logged_in?
    erb :'tweets/new'
  end

  post '/tweets' do
    redirect "/tweets/new" if params[:content].empty?
    @tweet = Tweet.create(content: params[:content])
    @tweet.user_id = current_user.id
    @tweet.save
    redirect "/tweets/#{@tweet.id}"
  end

  get '/tweets/:id' do
    redirect "/login" if !logged_in?
    @tweet = Tweet.find_by(id: params[:id])
    erb :'tweets/show_tweet'
  end

  get '/tweets/:id/edit' do
    redirect "/login" if !logged_in?
    @tweet = Tweet.find_by(id: params[:id])
    if @tweet && @tweet.user_id == current_user.id
      erb :'tweets/edit_tweet'
    else
      redirect "/tweets/"
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])
    redirect "/tweets/#{@tweet.id}/edit" if params[:content].empty?
    @tweet.update(content: params[:content])
    redirect "/tweets/#{@tweet.id}"
  end

  delete '/tweets/:id/delete' do
    tweet = Tweet.find_by(id: params[:id])
    tweet.delete if tweet && tweet.user_id == current_user.id
    redirect "/tweets"
  end

end
