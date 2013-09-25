require 'data_mapper'

env = ENV["RACK_ENV"] || "development"
# we're telling datamapper to use a postgres database on localhost. 
# The name will be "bookmark_manager_test" or "bookmark_manager_development"
# depending on the environment 
DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")

require './lib/link' #this needs to be done after datamapper is intialised 

DataMapper.finalize #after declaring models, finalise them

DataMapper.auto_upgrade! # tell datamapper to create database tables. 

