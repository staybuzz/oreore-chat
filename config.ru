require "rubygems"
require "sinatra"
require "sinatra/reloader"
require "haml"
require "sequel"
require "sass"


require "./oreore.rb"

run Sinatra::Application
