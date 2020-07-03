class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @users = User.all
      erb :"tweets/index"
    else
      redirect "/login"
    end
  end

  post '/tweets' do
    tweet = Tweet.new(content: params[:content])
    tweet.user = current_user
    if tweet.save
			redirect "/tweets/#{tweet.id}"
		else
			redirect "/tweets/new"
		end
  end

  delete '/tweets/:id' do
    if logged_in?
    if current_user == Tweet.find(params[:id]).user
      @tweet = Tweet.find(params[:id])
      @tweet.destroy
    end
    redirect "/tweets"
  else
    redirect "/login"
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :"tweets/new"
    else
      redirect "/login"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :"tweets/show"
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      if current_user == Tweet.find(params[:id]).user
        erb :"tweets/edit"
      else
        redirect "/tweets"
      end
    else
      redirect "/login"
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    @tweet.update(content: params[:content])

    if @tweet.save
			redirect "/tweets/#{@tweet.id}"
		else
			redirect "/tweets/#{@tweet.id}/edit"
		end

  end

end
