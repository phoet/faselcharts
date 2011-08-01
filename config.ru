$:.unshift ::File.join(::File.dirname(__FILE__), 'lib')

require 'rubygems'
require 'bundler'

Bundler.require

configure :development do
  puts "starting in development mode"
  Sinatra::Application.reset!
  require "sinatra/reloader"
end

require 'redis_store'
require 'application'
run Sinatra::Application
