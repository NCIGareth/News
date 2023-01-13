# frozen_string_literal: true

# rubocop:disable Style/Documentation
class WeatherController < ApplicationController
  def index
    if params[:location]
      location = params[:location]
      units = params[:units] || 'metric'
      weather = HTTParty.get("https://api.openweathermap.org/data/2.5/weather?q=#{location}&units=#{units}&appid=e24b337541816a7da96e2761e56597a9")
      @weather = JSON.parse(weather.body)
    else
    # Default location and units
    @location = params[:location] || "Ireland"
    @units = params[:units] || "metric"
    # Make API call using the location and units
    weather = HTTParty.get("https://api.openweathermap.org/data/2.5/weather?q=#{@location}&appid=e24b337541816a7da96e2761e56597a9&units=#{@units}")
    @weather = JSON.parse(weather.body)
    end

    # Additional weather information
    @wind_speed = @weather["wind"]["speed"]
    @pressure = @weather["main"]["pressure"]
    @visibility = @weather["visibility"]
    @sunrise = Time.at(@weather["sys"]["sunrise"]).strftime("%I:%M %p")
    @sunset = Time.at(@weather["sys"]["sunset"]).strftime("%I:%M %p")
  end

end
