require 'sinatra'
# using namespaces
require 'sinatra/namespace'
# module run
require 'sinatra/base'
require 'sequel'
require 'sequel/extensions/seed'

require 'pg'
require 'json'
require 'multi_json'

# app
# module SinatraAppModule
#   class App < Sinatra::Base

#     register Sinatra::Namespace

DB = Sequel.connect(
    adapter: :postgres,
    database: 'sinatra_dev',
    host: 'localhost',
    password: 'password',
    user: 'rails_admin',
    max_connections: 10,
# logger: Logger.new('log/db.log')
)


%w{controllers models routes}.each{|dir| Dir.glob("./#{dir}/*.rb", &method(:require))}

before do
  content_type 'application/json'
end

def collection_to_api(collection)
  MultiJson.dump(collection.map { |s| s.to_api })
end

    get '/' do
       'Hello My Sinatra - Easy and Wide World!'
      # redirect to('/hello/World')
    end

    get '/hello/:name' do
      "Welcome to our site, #{params[:name]}!"
    end

    get '/say/:thing' do |th|
      "Say #{th}"
    end

    get %r{/speak/([\w]+)} do |reg|
      "Hi #{reg}"
    end

    get '/jobs.?:format?' do
      'Маршрут работает'
    end

#     namespace '/api/v1' do
#       get '/say/*/to/*' do
#         "Saying #{params[:splat][0]} to #{params[:splat][1]}."
#      end
#    end
#   end
# end


