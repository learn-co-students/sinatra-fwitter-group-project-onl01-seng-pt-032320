# frozen_string_literal: true

class UsersController < ApplicationController
  get '/users/:user' do
    @user = User.find_by_slug(params[:user])

    erb :'users/show'
  end
end
