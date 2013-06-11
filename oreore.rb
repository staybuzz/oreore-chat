require "sinatra"
require 'haml'
require 'sequel'
require 'sqlite3'


get '/' do
  'Hello World!'
  haml :index
end

post '/' do
  @str = params[:str]
  redirect '/'
end
