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
            erb :'tweets/new'
        else
            redirect to '/login'
        end
    end

    post '/tweets' do
        if logged_in? && params[:content] != nil
            @tweet = current_user.tweets.build(content: params[:content])
            if @tweet.save
                redirect to "/tweets/#{@tweet.id}"
            else
                redirect to "/tweets/new"
            end
        else
            redirect to '/login'
        end
    end

    get '/tweets/:id' do
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            erb :'tweets/show'
        else
            redirect to '/login'
        end
    end

    get '/tweets/:id/edit' do
        if logged_in? 
            @tweet = Tweet.find_by_id(params[:id])
            if @tweet && @tweet.user == current_user
                erb :'tweets/edit'
            else
                redirect to '/tweets'
            end
        else
            redirect to '/login'
        end
    end

    patch '/tweets/:id' do					
        if logged_in? && params[:content] != ""			
            @tweet = Tweet.find_by_id(params[:id])		
            if @tweet && @tweet.user == current_user			
                if @tweet.update(content: params[:content])		
                    redirect "/tweets/#{@tweet.id}"	
                else		
                    redirect "/tweets/#{@tweet.id}/edit"	
                end		
            else			
                redirect '/tweets'		
            end			
        else				
            redirect '/login'			
        end				
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