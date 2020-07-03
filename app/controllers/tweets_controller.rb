class TweetsController < ApplicationController

    get '/tweets' do
        if logged_in?
            @tweets = Tweet.all
            erb :'/tweets/tweets'
        else
            redirect '/login'
        end
    end

    get '/tweets/new' do					
        if logged_in?	
            current_user			
            erb :'/tweets/new'			
        else				
            redirect '/login'			
        end				
    end					
                        
    post '/tweets' do					
        if logged_in? && params[:content] != ""				
            tweet = current_user.tweets.build(params)			
            tweet.save			
            redirect '/tweets'		
        else			
            redirect '/tweets/new'		
        end				
    end 

    get '/tweets/:id' do					
        if logged_in?				
            @tweet = Tweets.find_by_id(params[:id])			
            erb :'/tweets/tweets'		
        else			
            redirect '/login'			
        end				
    end 					
                        
    get '/tweets/:id/edit' do					
        if logged_in?				
            @tweet = Tweet.find_by_id(params[:id])			
            if @tweet			
                erb :'/tweets/edit'		
            else			
                redirect "/tweets/#{@tweet.id}"		
            end			
        else				
            redirect '/login'			
        end				
    end 					
                        
                        
    patch '/tweets/:id' do					
        if logged_in?				
            @tweet = Tweet.find_by_id(params[:id])			
            tweet.update(content: params[:content])		
            redirect "/tweets/#{@tweet.id}"	
        else		
            redirect "/tweets/#{@tweet.id}/edit"	
        end		
    end 					
                        
    delete '/tweets/:id' do					
        if logged_in?				
            tweet = current_user.twwets.find_by_id(params[:id])			
            if tweet			
                tweet.delete		
            end			
            redirect '/tweets'			
        else				
            redirect "/tweets/#{@tweet.id}/edit"		
        end				
    end 					
  
end
