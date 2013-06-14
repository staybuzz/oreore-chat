require "sinatra"
require 'sinatra/reloader'
require 'haml'
require 'sequel'
require 'sqlite3'

# DB = Sequel.sqlite('db/chat.db')

#DB.create_table :items do
#  primary_key :id
#  String :name
#  String :text
#end

Sequel.sqlite('db/chat.db')
class Entries < Sequel::Model
  unless table_exists?
    set_schema do
      primary_key :id
      string :name
      string :text
    end
    create_table
  end
end

get '/' do
  @entries = Entries.all
  haml :index
end

post '/add' do
  @str = params[:str]
  Entries.insert(:text => @str)
  redirect '/'
end
