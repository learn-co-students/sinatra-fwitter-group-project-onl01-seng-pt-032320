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
        user = Helpers.current_user(session)
        if params[:content].empty?
          redirect to '/tweets/new'
        end
        tweet = Tweet.create(:content => params["content"], :user_id => user.id)
    
        redirect to '/tweets'
      end


    get '/tweets/:id' do #show action 
        if !Helpers.is_logged_in?(session)
          redirect to '/login'
        else 
        @tweet = Tweet.find_by_id(params[:id])
        erb :"tweets/show"
        end 
    end

    get '/tweets/:id/edit' do 
        if !Helpers.is_logged_in?(session)
          redirect to '/login'
        end
        @tweet = Tweet.find_by_id(params[:id])
        if Helpers.current_user(session).id == @tweet.user_id
            erb :"tweets/edit"  #erb :"tweets/show"
        end 

        #erb :"tweets/edit"
        #redirect to '/tweets'
    end

    #post '/tweets/:id/edit' do 
        #@tweet.id = params[:id]
        #@tweet.content = params[:content]
       # @tweet.save
        #redirect "/tweets/#{@tweet.id}/edit"
   # end 


    patch '/tweets/:id' do 
        if Helpers.is_logged_in?
         tweet = Tweet.find_by_id(params[:id])
         #@tweet = Tweet.find(params[:content])
        end 
        if params[:content].empty?
            redirect to "/tweets/#{params[:id]}/edit"
        end
        tweet.update(content: params[:content])
        tweet.save
        redirect to "/tweets/#{tweet.id}"
    end


    post '/tweets/:id/delete' do
        if !Helpers.is_logged_in?(session)
            redirect to '/login'
        end
        @tweet = Tweet.find_by_id(params[:id])
        if @tweet.user_id != Helpers.current_user(session).id
        redirect to '/tweets'
        end
        @tweet.delete
        redirect to '/tweets' 
    end 
    
end 


#if Helpers.is_logged_in?
    #@tweet = Tweet.find_by_id(params[:id])
  #end 
 # if @tweet.user_id == Helpers.current_user(session).id
     # @tweet.delete
      #redirect to '/tweets'
  #else 
    #redirect to '/login'
  #end