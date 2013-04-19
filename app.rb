require 'sinatra'

def roll
  ['&#9856;','&#9857;','&#9858;','&#9859;','&#9860;','&#9861;'][rand(0..5)]
end

get '/' do
  "Hi! Try /dice."
end

get '/die' do
  roll
end

get '/dice/:n' do
  params[:n].to_i.times.map { roll }
end