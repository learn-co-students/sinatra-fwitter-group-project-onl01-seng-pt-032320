class TweetsController < ApplicationController

  get '/tweets' do
    if session[:User_id] != nil
      @user = User.find(session[:User_id])
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect 'login'
    end
  end

  get '/tweets/new' do
  if !Helpers.is_logged_in?(session)
    redirect to '/login'
  end
  erb :"/tweets/create_tweet"
end

post '/tweets' do
    user = Helpers.current_user(session)
    if params["content"].empty?
      redirect to '/tweets/new'
    end
    tweet = Tweet.create(:content => params["content"], :user_id => user.id)

    redirect to '/tweets'
  end

end
