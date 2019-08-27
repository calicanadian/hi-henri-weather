class UsersController < ApplicationController
  before_action :get_user_and_locations, only: [:show]

  def start
    # when user is logged out AKA app start
    # Should have a button GET STARTED
    # Click button to generate new user and be "logged in"
    # When user logs out, they go here
    if @current_user
      redirect_to root_url
    else
      render start_users_path
    end
  end

  def show
    if @user.id != session[:user_id]
      redirect_to root_url
    end
  end

  def create
    @user = User.generate_new_user
    if @user
      redirect_to root_url
    else
      redirect_to start_users_path
    end
  end

  private

  def get_user_and_locations
    @user = User.find(params[:id])
    @locations = @user.locations
  end
end
