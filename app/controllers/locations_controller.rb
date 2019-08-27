class LocationsController < ApplicationController

  def create
    zip_code = params[:zip_code].blank? ? '93401' : params[:zip_code]
    
  end
end
