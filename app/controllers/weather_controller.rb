# frozen_string_literal: true

class WeatherController < ApplicationController
  def index
    weather = HTTParty.get('https://api.openweathermap.org/data/2.5/weather?lat=53.3498&lon=6.2603&appid=e24b337541816a7da96e2761e56597a9&units=metric')
    @weather = JSON.parse(weather.body)
  end
end
