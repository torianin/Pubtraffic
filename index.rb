require 'sinatra'
require 'haml'
require 'coffee-script'

set :haml, :format => :html5

get '/' do
  haml :index
end

get '/app.js' do
  coffee :app
end
