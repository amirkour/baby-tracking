require File.join(File.dirname(__FILE__), 'app.rb')
$stdout.sync = true
run Sinatra::Application
