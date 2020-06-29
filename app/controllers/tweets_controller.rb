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
    end 

    delete "/tweets/:id/delete" do 
    end 

end
