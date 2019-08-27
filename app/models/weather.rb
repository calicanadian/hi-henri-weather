class Weather < ApplicationRecord

  def check_weather_by_zip(zip_code)
    @conn = Faraday.new(url: ENV['WEATHER_API_URL']) do |api|
      api.request   :url_record
      api.request   :retry, max: 0
      api.options.timeout = 30
      api.options.open_timeout = 5
      api.response  :logger
      api.adapter   Faraday.default_adapter
    end

    begin
      response = @conn.post do |req|
        req.url ENV['WEATHER_API_URL']
        req.headers['Content-Type'] = 'application/json'
        req.headers['x-api-key'] = ENV['WEATHER_API_KEY']
        req.body = { 'zip': "#{zip_code},us", 'appid': ENV['WEATHER_APP_ID']}
      end
      if response.status == 200
        return JSON.parse(response.body)
      end
    rescue Exception => error
      Rails.logger(error.message)
    end
  end
end
