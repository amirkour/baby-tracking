require 'sinatra'
require 'haml'
require "sinatra/reloader"

set :haml, :format => :html5

configure :production do
    enable :reloader
end

get '/feed/:id' do
    haml :edit_feed
end

get '/feed' do
    haml :feed
end

get '/' do
    haml :index
end
