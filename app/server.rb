require 'data_mapper'
require 'sinatra'
require 'database_cleaner'	
# require_relative './views/index'

env = ENV["RACK_ENV"] || "development"
# we're telling datamapper to use a postgres database on localhost. 
# The name will be "bookmark_manager_test" or "bookmark_manager_development"
# depending on the environment 
DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")

require './lib/link' #this needs to be done after datamapper is intialised 
require './lib/tag'
DataMapper.finalize #after declaring models, finalise them

DataMapper.auto_upgrade! # tell datamapper to create database tables. 


get '/' do 
	@links = Link.all
	erb :index
end 

post '/links' do 
	url = params["url"]
	title = params["title"]
	tags = params["tags"].split(" ").map do |tag|
		Tag.first_or_create(:text => tag)
	end 
	Link.create(:url => url, :title => title, :tags => tags)

	redirect to('/')
end 

