require "sinatra"
require 'haml'
require 'sequel'
require 'sqlite3'


get '/' do
  'Hello World!'
  haml :index
end

post '/add' do
  @str = params[:str]
  haml :index
end
