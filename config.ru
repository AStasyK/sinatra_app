# simple run
# require './sinatra_app'
# run Sinatra::Application

# module run
root = File.expand_path File.dirname(__FILE__)
require File.join( root, 'sinatra_app' )

# app = Rack::Builder.app do
#   run SinatraAppModule::App
# end

# run app

run Sinatra::Application