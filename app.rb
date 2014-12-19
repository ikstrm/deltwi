require 'sinatra'
require 'gyazo'

get '/' do
  client = Gyazo::Client.new
  client.upload('prof.png')
end
