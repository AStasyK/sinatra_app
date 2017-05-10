require 'sinatra'
# using namespaces
require 'sinatra/namespace'
# module run
require 'sinatra/base'

# app
module SinatraAppModule
  class App < Sinatra::Base

    register Sinatra::Namespace

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

    namespace '/api/v1' do
      get '/say/*/to/*' do
        "Saying #{params[:splat][0]} to #{params[:splat][1]}."
      end
    end
  end
end


