require "rubygems"
require "sinatra"
require "sinatra/reloader"
require "haml"
require "sequel"


require "./oreore.rb"

run Sinatra::Application
