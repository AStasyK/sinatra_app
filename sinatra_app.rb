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

%w{controllers models routes}.each{|dir| Dir.glob("./#{dir}/*.rb", &method(:require))}

DB = Sequel.connect(
    adapter: :postgres,
    database: 'sinatra_seq_dev',
    host: 'localhost',
    password: 'password',
    user: 'sinatra_admin',
    max_connections: 10,
# logger: Logger.new('log/db.log')
)

# лучше перенести в rake-task
Sequel::Seed.setup :development
Sequel.extension :seed
Sequel::Seeder.apply(DB, './seeds')

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


