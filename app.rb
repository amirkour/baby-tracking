require 'sinatra'
require 'haml'

set :haml, :format => :html5

get '/feed' do
    haml :feed
end

get '/' do
    haml :index
end
