class TweetsController < ApplicationController
    
    get '/tweets' do
        if Helpers.is_logged_in?(session)
            @tweets = Tweet.all
            #binding.pry
            @user = Helpers.current_user(session)
            erb :"tweets/tweets"
        else
            redirect '/login'
        end 
    end

    get '/tweets/new' do
        if Helpers.is_logged_in?(session)
            erb :"tweets/new"
        else
            redirect '/login'
        end
    end


    post '/tweets' do
        #@tweets = Tweet.create(content: params[:content])
           # redirect to "tweets/tweets/#{@tweet.id}"
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


    get '/tweets/:id' do
        if !Helpers.is_logged_in?(session)
          redirect to '/login'
        end
        @tweet = Tweet.find(params[:id])
        erb :"tweets/show_tweet"
      end

      post '/tweets/:id/delete' do
        if !Helpers.is_logged_in?(session)
          redirect to '/login'
        end
        @tweet = Tweet.find(params[:id])
        if Helpers.current_user(session).id != @tweet.user_id
          redirect to '/tweets'
        end
        @tweet.delete
        redirect to '/tweets'
      end
end
