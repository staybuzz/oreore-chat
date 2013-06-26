# encoding: utf-8
require "sinatra"
require 'sinatra/reloader'
require 'haml'
require 'sequel'

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
  @entries = Entries.all
  "#{@entries}"
end

get '/login' do
  haml :login
end

post '/login' do
  Entries.insert(:name=>params[:hn], :text=>"#{params[:hn]} is entered!")
  redirect "/room/:hn"
end

get '/room/:hn' do
  @entries = Entries.all
  haml :chat
end

post '/add' do
  Entries.insert(:name=>params[:hn], :text=>params[:str])
  @entries = Entries.all
  # redirect '/room/:hn'
  haml :chat
end

__END__

@@login
!!!
%html
  %head
    %title Chat Login
  %body
    #main
      %h1 Welcome To My ChatRoom!!
      %div Please Enter Your Name
      %form{:action=>"/login", :method=>"post"}
        %input{:type=>"texfield", :name=>"hn"}
        %input{:type=>"submit", :value=>"send"}
