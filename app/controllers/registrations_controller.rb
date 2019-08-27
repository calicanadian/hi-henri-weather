class RegistrationsController < ApplicationController

  def create
    user = User.generate_new_user

    if user
      session[:user_id] = user.id
      redirect_to root_url, notice: "You are now logged in as #{user.email}"
    else
      redirect_to start_users_path, alert: "There was a problem"
    end
  end

end
