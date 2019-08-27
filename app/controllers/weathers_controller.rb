class WeathersController < ApplicationController

  def index
    if @current_user
      @user = @current_user
      # @locations = @user&.locations.blank? ? nil : @user.locations
    else
      redirect_to start_users_path
    end
  end

  def get_weather

  end

  def save_location

  end
end
