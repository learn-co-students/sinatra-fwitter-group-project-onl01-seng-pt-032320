require 'pry'
class TweetsController < ApplicationController

    get "/tweets" do
        if Helpers.is_logged_in?(session)
            @user = Helpers.current_user(session)
            @tweets = Tweet.all
            erb :'/tweets/index'
        else
            redirect "/login"
        end
    end

    get "/tweets/new" do 
        if Helpers.is_logged_in?(session)
            erb :'/tweets/new'
        else
            redirect "/login"
        end
    end 

    post "/tweets" do 
        if params[:content] == ""
            redirect "/tweets/new"
        end 
        @user = Helpers.current_user(session)
        @tweet = Tweet.create(:content => params[:content], :user_id => @user.id)
        @tweet.save

        redirect to "/tweets"
    end 

    get "/tweets/:id" do
        if Helpers.is_logged_in?(session)
            @tweet = Tweet.find_by_id(params[:id])
            erb :'/tweets/show'
        else
            redirect "/login"
        end
    end 

    get "/tweets/:id/edit" do 
        if Helpers.is_logged_in?(session)
            @tweet = Tweet.find_by_id(params[:id])
            @user = Helpers.current_user(session)
            if @tweet.user_id == @user.id 
                erb :'/tweets/edit'
            else
                redirect "/tweets/#{@tweet.id}"
            end 
        else
            redirect "/login"
        end
    end 

    post "/tweets/:id" do 
        binding.pry
        if params[:content] == ""
            binding.pry
            redirect "/tweets/#{@tweet.id}/edit"
        end 

        @tweet = Tweet.find_by_id(params[:id])
        @tweet.content = params[:content]
        @tweet.save
        redirect to "/tweets/#{@tweet.id}"
    end 

    delete "/tweets/:id/delete" do 
        if Helpers.is_logged_in?(session)
            @tweet = Tweet.find_by_id(params[:id])
            @user = Helpers.current_user(session)
            if @tweet.user_id == @user.id 
                @tweet.delete
                redirect "/tweets"
            else
                redirect "/tweets/#{@tweet.id}"
            end 
        else
            redirect "/login"
        end
    end 

end
