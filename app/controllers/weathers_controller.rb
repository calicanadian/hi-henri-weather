class WeathersController < ApplicationController
  include WeathersHelper

  def index
    if @current_user
      @user = @current_user
      @locations = @user&.locations.blank? ? nil : @user.locations
    else
      redirect_to start_users_path
    end
  end

  def get_weather
    zip_code = params[:weather][:zip_code].blank? ? '93401' : params[:weather][:zip_code]
    @weather = JSON.parse(get_weather_by_zip(zip_code).to_json, object_class: OpenStruct)
    @location = Location.create!(
      lon: @weather&.coord[:lon],
      lat: @weather&.coord[:lat],
      zipcode: zip_code,
      country: @weather&.sys[:country],
      city: @weather&.name,
      temperature: @weather&.main[:temp],
      temp_min: @weather&.main[:temp_min],
      temp_max: @weather&.main[:temp_max],
      temp_avg: get_average_temp(@weather&.main[:temp_min], @weather&.main[:temp_max]))
    UserLocation.create!(user_id: @current_user.id, location_id: @location.id)
    redirect_to root_url
  end

  def refresh_weather
    p "PARAMS: #{params.inspect}"
    zip_code = params[:zipcode]
    locationId = params[:location_id]
    @weather = JSON.parse(get_weather_by_zip(zip_code).to_json, object_class: OpenStruct)
    @location = Location.find(locationId)
    if @location.blank?
      render json: {message: 'Location not found', status: 404}
    else
      if @location.update_attributes(
          temperature: @weather&.main[:temp],
          temp_min: @weather&.main[:temp_min],
          temp_max: @weather&.main[:temp_max],
          temp_avg: get_average_temp(@weather&.main[:temp_min], @weather&.main[:temp_max])
        )
        render json: {location: @location, status: :success }
      else
        render json: {errors: @location.errors, status: 422}
      end
    end
    # begin
    #
    # rescue Exception => error
    #   render json: {error: error.message, status: 422}
    #   Rails.logger.info error.message
    # end
  end
end

#<OpenStruct coord=#<OpenStruct lon=-120.65, lat=35.26>, weather=[#<OpenStruct id=701, main="Mist", description="mist", icon="50n">], base="stations", main=#<OpenStruct temp=293.64, pressure=1011, humidity=53, temp_min=288.71, temp_max=304.26>, visibility=16093, wind=#<OpenStruct speed=5.1, deg=300>, clouds=#<OpenStruct all=1>, dt=1566865608, sys=#<OpenStruct type=1, id=5787, message=0.0085, country="US", sunrise=1566826240, sunset=1566873518>, timezone=-25200, id=0, name="San Luis Obispo", cod=200>

# Location(id: integer, lon: decimal, lat: decimal, zipcode: string, country: string, city: string, display_order: integer, created_at: datetime, updated_at: datetime)
