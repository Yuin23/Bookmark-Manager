require 'data_mapper'
require 'sinatra'
require 'database_cleaner'	

enable :sessions
set :session_secret, 'super super secret'

env = ENV["RACK_ENV"] || "development"
# we're telling datamapper to use a postgres database on localhost. 
# The name will be "bookmark_manager_test" or "bookmark_manager_development"
# depending on the environment 
DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")

require './lib/link'	# this needs to be done after datamapper is intialised 
require './lib/tag'
require './lib/user'	# DO NOT FORGET !!  #
DataMapper.finalize 	# after declaring models, finalise them

DataMapper.auto_upgrade! # tell datamapper to create database tables. 


get '/' do 
	@links = Link.all
	erb :index
end 

get '/tags/:text' do 
	tag = Tag.first(:text => params[:text])
	@links = tag ? tag.links : []
	erb :index
end 

get '/users/new' do 		###############################################	
	erb :"users/new"		# note the view is in views/users/new.erb     #
end							# we need the quotes because otherwise        #
							# ruby would divide the symbol :users by the  #
							# variable new (which makes no sense)         #
							###############################################

post '/links' do 
	url = params["url"]
	title = params["title"]
	tags = params["tags"].split(" ").map do |tag|
		Tag.first_or_create(:text => tag)
	end 
	Link.create(:url => url, :title => title, :tags => tags)

	redirect to('/')
end 

post '/users' do
	User.create(:email => params[:email],
				:password => params[:password],
				:password_confirmation => params[:password_confirmation])
	session[:user_id] = user.id 
	redirect to('/')
end 

helpers do 
	def current_user
		@current_user ||=User.get(session[:user_id]) if session[:user_id]
	end 
end 


