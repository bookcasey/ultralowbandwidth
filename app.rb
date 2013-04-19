require 'sinatra'

require 'geocoder'
require 'forecast_io'

Forecast::IO.api_key = ENV['FORECAST_KEY']

before do
  content_type "text/html"
end

get '/' do
  "Try /weather/48201"
end

get '/weather/:z' do
  s = Geocoder.search(params[:z])[0]
  f = Forecast::IO.forecast(s.latitude.to_s, s.longitude.to_s)
  d =  f.daily.data[0]
  "#{s.address}:<br>
  #{((d.temperatureMax + d.temperatureMin)/2).ceil}&deg;F<br> 
  #{d.summary}"
end

get '/w/:z' do
  redirect "/weather/#{params[:z]}"
end

