class TweetsController < ApplicationController
    get '/tweets' do
    
        if logged_in?
          @tweets = Tweet.all
          erb :'tweets/tweets'
        else
          redirect to '/login'
        end
    end

    get '/tweets/new' do
        if logged_in?
          erb :'/tweets/create'
        else
          redirect to '/login'
        end
    end

    get '/tweets/:id' do 
        if logged_in?
        @tweet = Tweet.find_by_id(params[:id])
        erb :'tweets/show_tweet'
        else
           redirect to '/login' 
        end
    end

    post '/tweets' do
        @tweet = Tweet.create(:content =>params[:content], :user_id =>params["user_id"])
        redirect to "/tweets/#{@tweet.id}"
    end


    get '/tweets/:id/edit' do
        @tweet = Tweet.find_by_id(params[:id])
        erb :'/tweets/edit_tweet'
    end


    patch '/tweets/:id' do 
        @tweet = Tweet.find_by_id(params[:id])
        @tweet.content = params[:content]
        @tweet.save
        redirect to "/tweets/#{@tweet.id}"
    end

    delete '/tweets/:id' do
        @tweet = Article.find_by_id(params[:id])
        @tweet.delete
        redirect to '/tweets'
    end


    

end
