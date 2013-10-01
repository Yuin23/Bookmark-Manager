require 'data_mapper'
require 'sinatra'
require 'database_cleaner'
require 'rack-flash'
require 'sinatra/partial' 

require_relative 'controllers/users'
require_relative 'controllers/sessions'
require_relative 'controllers/links'
require_relative 'controllers/tags'
require_relative 'controllers/application'

require_relative 'data_mapper_setup'


enable :sessions
set :session_secret, 'super super secret'
use Rack::Flash
#register Sinatra::Partial
set :partial_template_engine, :erb


# env = ENV["RACK_ENV"] || "development"
# # we're telling datamapper to use a postgres database on localhost. 
# # The name will be "bookmark_manager_test" or "bookmark_manager_development"
# # depending on the environment 
# DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")

# require_relative 'models/link'	# this needs to be done after datamapper is intialised 
# require_relative 'models/tag'
# require_relative 'models/user'	# DO NOT FORGET !!  #

# DataMapper.finalize 	# after declaring models, finalise them

# DataMapper.auto_upgrade! # tell datamapper to create database tables. 





# helpers do 
# 	def current_user
# 		@current_user ||=User.get(session[:user_id]) if session[:user_id]
# 	end 
# end 


