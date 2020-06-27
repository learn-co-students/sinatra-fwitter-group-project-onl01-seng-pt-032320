class TweetsController < ApplicationController
  get "/tweets" do
    if !Helpers.logged_in?(session)
      redirect to "/login"
    end
    @tweets = Tweet.all
    @user = Helpers.current_user(session)
    erb :'tweets/tweets'
  end

  get "/tweets/new" do
    if !Helpers.logged_in?(session)
      redirect to "/login"
    end
    erb :"/tweets/create_tweet"
  end

  post "/tweets" do
    user = Helpers.current_user(session)
    if params[:content] == ""
      redirect to "/tweets/new"
    end
    tweet = Tweet.create(content: params[:content], user_id: user.id)
    redirect to "/tweets"
  end

  get "/tweets/:id" do
    if !Helpers.logged_in?(session)
      redirect to "/login"
    end
    @tweet = Tweet.find_by_id(params[:id])
    erb :'tweets/show_tweet'
  end

  get "/tweets/:id/edit" do
    if Helpers.logged_in?(session)
        @tweet = Tweet.find_by_id(params[:id]) 
         if @tweet.user_id == Helpers.current_user(session).id 
            erb :'tweets/edit_tweet'
        else
            redirect to '/tweets'
        end
    else 
        redirect "/login"
    end 
end 


  patch "/tweets/:id" do
    tweet = Tweet.find(params[:id])
  if params["content"].empty?
    redirect to "/tweets/#{params[:id]}/edit"
  end
  tweet.update(:content => params["content"])
  tweet.save

  redirect to "/tweets/#{tweet.id}"
end

  post "/tweets/:id/delete" do
    if !Helpers.logged_in?(session)
      redirect to "/login"
    end
    @tweet = Tweet.find_by_id(params[:id])
    if Helpers.current_user(session).id != @tweet.user_id
      redirect to "/tweets"
    end
    @tweet.delete
    redirect to "/tweets"
  end
end
