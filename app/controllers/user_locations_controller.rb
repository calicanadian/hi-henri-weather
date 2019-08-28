class UserLocationsController < ApplicationController
  before_action :get_user_location, only: [:destroy]

  def destroy
    if @user_location.destroy
      # redirect_back(fallback_location: root_url, notice: 'Saved Location destroyed')
      render json: { status: :success }
    else
      # redirect_back(fallback_location: root_url, alert: @user_location.errors)
      render json: { status: 422 }
    end
  end

  private

  def get_user_location
    @user_location = UserLocation.where(user_id: params[:user_id], location_id: params[:location_id]).first
  end
end
