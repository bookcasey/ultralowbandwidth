require 'sinatra'

require 'geocoder'
require 'forecast_io'

Forecast::IO.api_key = ENV['FORECAST_KEY']

def roll
  ['&#9856;','&#9857;','&#9858;','&#9859;','&#9860;','&#9861;'][rand(0..5)]
end

get '/' do
  content_type 'text/html'
  "Hi! Try /die or /dice/10"
end

get '/die' do
  content_type 'text/html'
  roll
end

get '/dice/:n' do
  content_type 'text/html'
  params[:n].to_i.times.map { roll }
end

get '/weather/:z' do
  s = Geocoder.search(params[:z])
  f = Forecast::IO.forecast(s[0].latitude.to_s, s[0].longitude.to_s)
  d = f.daily.data[0]

  # not happy with this or sure that it's right

  "#{d.temperatureMin.to_s}&deg; - #{d.temperatureMax.to_s}&deg;"
end
