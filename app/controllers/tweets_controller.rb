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

    get '/tweets/new' do #new action 
        if Helpers.is_logged_in?(session)
            erb :"tweets/create_tweet"
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


    get '/tweets/:id' do #show action 
        if !Helpers.is_logged_in?(session)
          redirect to '/login'
        else 
        @tweet = Tweet.find(id: params[:id])
        erb :"tweets/show"
        end 
    end

    get '/tweets/:id/edit' do
        if !Helpers.is_logged_in?(session)
          redirect to '/login'
        end
        @tweet = Tweet.find(params[:id])
        if Helpers.current_user(session).id != @tweet.user_id
          redirect to '/tweets'
        end
        erb :"tweets/edit"
    end

    patch '/tweets/:id' do 
        if Helpers.is_logged_in?
         @tweet = Tweet.find(params[:id])
        end 
        if params[:content].empty?
            redirect to "/tweets/#{params[:id]}/edit"
        end
        tweet.update(content: params[:content])
        tweet.save
        redirect to "/tweets/#{tweet.id}"
    end


    delete '/tweets/:id/delete' do
        if logged_in?
          @tweet = Tweet.find_by_id(params[:id])
        if @tweet && @tweet.user == current_user
            @tweet.delete
        end
          redirect to '/tweets'
        else
          redirect to '/login'
        end
      
    end 
end 
