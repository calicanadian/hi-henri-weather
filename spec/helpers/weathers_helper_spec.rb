require 'rails_helper'

describe WeathersHelper do
  it 'should get weather by zip' do
    result = get_weather_by_zip(93420)
    expect(result).not_to be_nil
    expect(result["name"]).to eql("Arroyo Grande")
  end

  it 'should convert kelvin to fahrenheit' do
    kelvin = 296.71
    expect(calculate_fahrenheit(kelvin)).to eql(74)
  end

  it 'should convert kelvin to celcius' do
    kelvin = 296.71
    expect(calculate_celcius(kelvin)).to eql(24)
  end

  it 'should calculate average temperature' do
    kelvin_min = 294.82
    kelvin_max = 298.71
    expect(get_average_temp(kelvin_min, kelvin_max)).to eql(296.765)
  end
end
