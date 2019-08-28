module WeathersHelper
  def get_weather_by_zip(zip_code)
    @conn = Faraday.new(url: "#{ENV['WEATHER_API_URL']}?zip=#{zip_code},us") do |api|
      api.request   :url_encoded
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
      end
      if response.status == 200
        return JSON.parse(response.body)
      end
    rescue Exception => error
      puts error.message
      Rails.logger.info error.message
    end
  end

  def get_average_temp(min, max)
    begin
      average_temp = (min + max) / 2
      return average_temp
    rescue Exception => error
      puts error.message
      Rails.logger.info error.message
    end
  end

  def calculate_celcius(temp)
    begin
      return (temp - 273.15).round
    rescue Exception => error
      puts error.message
      Rails.logger.info error.message
    end
  end

  def calculate_fahrenheit(temp)
    begin
      return ((temp - 273.15) * 9/5 + 32).round
    rescue Exception => error
      puts error.message
      Rails.logger.info error.message
    end
  end
end
