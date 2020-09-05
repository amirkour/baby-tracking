require 'sinatra'
require 'haml'
require "sinatra/reloader"
require 'sinatra/custom_logger'
require 'logger'

set :haml, :format => :html5

# TODO - the web server prolly shouldn't be webrick out on prod ...
# see this article: https://devcenter.heroku.com/articles/ruby-default-web-server

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
    settings.logger.level = Logger::WARN
    settings.logger.error("Woah, prod enabled!?")
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
