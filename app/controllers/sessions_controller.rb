class SessionsController < ApplicationController
  skip_before_action :set_current_user
  def create
    user = User.find_by(email: params[:user][:email]).try(:authenticate, params[:user][:password])
    if user
      session[:user_id] = user.id
      redirect_to root_url
    else
      redirect_back(fallback_location: start_users_path)
    end
  end

  def logout
    reset_session
    redirect_to start_users_path
  end

  def sign_out
    reset_session
    redirect_to start_users_path
  end

  def logged_in
    if @current_user
      render json: { logged_in: true, user: @current_user }
    else
      render json: { logged_in: false }
    end
  end

end
