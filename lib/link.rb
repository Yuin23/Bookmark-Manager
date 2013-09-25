#  This class correponds to a table in the database
#  We can use it to manipulate the database
class Link

																	
	include DataMapper::Resource # this makes the instances of this class Datamapper resources

	# this block describes what resources our model will have
	property :id, Serial # Serial means that it will be auto-incremented for every record
	property :title, String
	property :url, String

end 
