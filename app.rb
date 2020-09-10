require 'sinatra'
require 'haml'
require 'yaml'
require 'sinatra/activerecord'
require "sinatra/reloader"
require 'sinatra/custom_logger'
require "sinatra/json"
require 'logger'
require_relative './models/models.rb'

set :haml, :format => :html5
db_passy = "TODO"

#
# TODO - do I need this? or is the init below enough ..?
#
# set :database, "mysql://root:#{db_passy}@localhost:3306/baby_tracking"

#
# TODO - the web server prolly shouldn't be webrick out on prod ...
#
# see this article: https://devcenter.heroku.com/articles/ruby-default-web-server
#

#
# TODO - for DB/AR access, use this, or something like it:
# see this article for AR in rack apps: https://devcenter.heroku.com/articles/rack
#
ActiveRecord::Base.establish_connection("mysql2://root:#{db_passy}@localhost:3306/baby_tracking")

#
# TODO - edit connection string here ..?
# TODO - log-file settings, like rolling and size restrictions ..?
#
configure :development do
    set :logger, Logger.new('./bin/logfile.log')
    settings.logger.level = Logger::DEBUG
    settings.logger.debug("Woah, debug enabled!?")
    enable :reloader
end
configure :production do
    set :logger, Logger.new(STDOUT)

    #
    # TODO - change this in actual prod - i'm testing for now
    #        but it should be a logging service w/ appropriate level
    settings.logger.level = Logger::WARN
    settings.logger.error("Woah, prod enabled!?")
end

def foober_loober_helper
    [{
        :start => '10:30',
        :end => '10:32',
        :duration => '2m',
        :notes => 'blabla'
    },{
        :start => '11:00',
        :end => '11:30',
        :duration => '30m',
        :notes => 'long feed!?'
    }]
end

get '/api/v1/stuff' do
    json foober_loober_helper
end

#
# TODO - these routes should probably be something
# like /baby/:id/feed/:id
#
get '/feed/:id' do
    haml :edit_feed
end

#
# TODO - these routes should probably be something
# like /baby/:id/feed/:id
#
get '/feed' do
    haml :feed, :locals => {:sessions => foober_loober_helper}
end

get '/' do
    haml :index
end
