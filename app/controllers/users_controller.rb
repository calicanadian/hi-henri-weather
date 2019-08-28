class UsersController < ApplicationController
  skip_before_action :set_current_user, only: [:start]
  before_action :get_user_and_locations, only: [:show, :update]

  def start
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

  def update
    if @current_user.update_attributes user_params
      redirect_to signin_users_path
    else
      redirect_back(fallback_location: user_path(@current_user), alert: User.errors)
    end
  end

  def signin
    reset_session
    if @current_user
      redirect_to user_path(@current_user)
    end
  end

  private

  def get_user_and_locations
    @user = User.find(params[:id])
    @locations = @user.locations.sorted
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
