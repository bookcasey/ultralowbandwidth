require 'sinatra'

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