require 'sinatra'
require './lib/tasks/db'

namespace :db do
  task :environment do
    require 'sequel'
    # common part of dbs at the end
    ENV['DATABASE_URL'] ||= 'postgres://rails_admin:password@localhost/sinatra'
    ENV['RACK_ENV'] ||= 'development'
    ENV['DATABASE'] = 'sinatra_dev' if ENV['RACK_ENV'] == 'development'
    ENV['DATABASE'] = 'sinatra_test' if ENV['RACK_ENV'] == 'test'
    ENV['DATABASE'] = 'sinatra_prod' if ENV['RACK_ENV'] == 'production'
  end
end