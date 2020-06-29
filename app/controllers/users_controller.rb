class UsersController < ApplicationController

get '/profile' do
    @user = current_user
    erb :'/users/show'
end


end
