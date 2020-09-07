require 'sinatra'
require 'haml'
require "sinatra/reloader"
require 'sinatra/custom_logger'
require "sinatra/json"
require 'logger'

set :haml, :format => :html5

#
# TODO - the web server prolly shouldn't be webrick out on prod ...
#
# see this article: https://devcenter.heroku.com/articles/ruby-default-web-server
#

#
# TODO - for DB/AR access, use this, or something like it:
# require 'active_record'
# ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || 'postgres://localhost/mydb')
#
# see this article for AR in rack apps: https://devcenter.heroku.com/articles/rack
#

# TODO - edit connection string here ..?
# TODO - log-file settings, like rolling and size restrictions ..?
configure :development do
    set :logger, Logger.new('./bin/logfile.log')
    settings.logger.level = Logger::DEBUG
    settings.logger.debug("Woah, debug enabled!?")
    enable :reloader
end
configure :production do
    set :logger, Logger.new(STDOUT)

    # TODO - change this in actual prod - i'm testing for now
    #        but it should be a logging service w/ appropriate level
    settings.logger.level = Logger::WARN
    settings.logger.error("Woah, prod enabled!?")
end

get '/api/v1/stuff' do
    json [{
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

# TODO - these routes should probably be something
# like /baby/:id/feed/:id
get '/feed/:id' do
    haml :edit_feed
end

# TODO - these routes should probably be something
# like /baby/:id/feed/:id
get '/feed' do
    haml :feed
end

get '/' do
    logger.info 'some message here'
    logger.error 'some error'
    logger.warn "WARNING: loggers class is #{logger.class.name}"
    haml :index
end
