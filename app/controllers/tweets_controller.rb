# frozen_string_literal: true

class TweetsController < ApplicationController
  get '/tweets', auth: nil do
    @user = current_user
    @tweets = Tweet.all

    erb :'/tweets/index'
  end

  post '/tweets', auth: nil do
    tweet = Tweet.create(content: params[:content])

    if tweet.valid?
      tweet.user = current_user
      tweet.save

      redirect "/tweets/#{tweet.id}"
    else
      redirect '/tweets/new'
    end
  end

  get '/tweets/new', auth: nil do
    erb :'/tweets/new'
  end

  get '/tweets/:id', auth: nil do
    @tweet = Tweet.find(params[:id])

    erb :'/tweets/show'
  end

  patch '/tweets/:id', auth: nil do
    tweet = Tweet.find(params[:id])
    tweet.update(content: params[:content])

    if tweet.valid?
      tweet.save

      redirect "/tweets/#{tweet.id}"
    else
      redirect "/tweets/#{tweet.id}/edit"
    end
  end

  delete '/tweets/:id', auth: nil do
    tweet = Tweet.find(params[:id])

    tweet.destroy if tweet.user == current_user

    redirect '/tweets'
  end

  get '/tweets/:id/edit', auth: nil do
    @tweet = Tweet.find(params[:id])

    erb :'/tweets/edit'
  end
end
