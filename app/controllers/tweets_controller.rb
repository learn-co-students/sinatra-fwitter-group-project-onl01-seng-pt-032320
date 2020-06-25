class TweetsController < ApplicationController

  get '/tweets' do
    binding.pry
    if session[:User_id] != nil
      @user = User.find_by_id(session[:User_id])
      @tweets = Tweet.all
      binding.pry
      erb :'/tweets/tweets'
    else
      redirect 'login'
    end
  end

end
