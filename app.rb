require 'sinatra'

require 'geocoder'
require 'forecast_io'

Forecast::IO.api_key = ENV['FORECAST_KEY']

def roll
  ['&#9856;','&#9857;','&#9858;','&#9859;','&#9860;','&#9861;'][rand(0..5)]
end

before do
  content_type "text/html"
end

get '/' do
  "Hi! Try /die or /dice/10"
end

get '/die' do
  roll
end

get '/dice/:n' do
  params[:n].to_i.times.map { roll }
end

get '/weather/:z' do
  s = Geocoder.search(params[:z])
  f = Forecast::IO.forecast(s[0].latitude.to_s, s[0].longitude.to_s)
  d =  f.daily.data[0]
  @t =  (d.temperatureMax + d.temperatureMin)/2

  def coat
    if @t <= 50
      "Wear a light coat."
    elsif @t <= 30
      "Wear a coat and a scarf."
    end
  end

  "#{f.hourly.summary} #{coat}" 
end

get '/w/:z' do
  call env.merge('PATH_INFO' => '/weather/:z')
end
