$:.unshift ::File.join(::File.dirname(__FILE__), 'lib')

require 'rubygems'
require 'bundler'

Bundler.require

puts "starting"
configure :development do |c|
  puts "starting in development mode"
  Sinatra::Application.reset!
  require "sinatra/reloader"
  c.also_reload "lib/**/*.rb"
end

require 'redis_store'
require 'application'
run Sinatra::Application
