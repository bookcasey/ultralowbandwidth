require 'sinatra'

require 'geocoder'
require 'forecast_io'
require 'google_directions'

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

get '/directions/:f/:t' do
  @instructions = []

  x = Nokogiri::XML(GoogleDirections.new("48170", "48104").xml)
  x.xpath("//DirectionsResponse//route//leg//step").each do |q|
    q.xpath("html_instructions").each do |h|
      @instructions.push(h.content)
    end
  end

  @c = x.xpath("//copyrights").to_s
  @pd = x.xpath("//overview_polyline//points").to_s.gsub("<points>", "").gsub("</points>", "").gsub("\\", "\\\\")

  erb "<img src=\"https://maps.googleapis.com/maps/api/staticmap?size=300x300&path=weight:3%7Ccolor:black%7Cenc:#{@pd}&format=jpeg&sensor=false\" ><ol><% @instructions.each do |i| %><li><%= i %></li><%end%></ol> <%= @c %>"
end
