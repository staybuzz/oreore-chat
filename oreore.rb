# encoding: utf-8
require "sinatra"
require 'sinatra/reloader'
require 'haml'
require 'sequel'

set :haml, :escape_html => true
Sequel::Model.plugin(:schema)

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
  haml :login
end

post '/login' do
  Entries.insert(:name=>params[:hn], :text=>"#{params[:hn]} is entered!")
  redirect "/room/#{params[:hn]}"
end

get '/room/:hn' do
  @entries = Entries.all
  haml :chat
end

post '/post' do
  Entries.insert(:name=>params[:hn], :text=>params[:str])
  redirect "room/#{params[:hn]}"
end
