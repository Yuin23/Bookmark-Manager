get '/users/new' do 		
	@user = User.new		###############################################	
	erb :"users/new"		# note the view is in views/users/new.erb     #
end							# we need the quotes because otherwise        #
							# ruby would divide the symbol :users by the  #
							# variable new (which makes no sense)         #
							###############################################


post '/users' do
	@user= User.new(:email => params[:email],		# initialize the object without saving 								
				:password => params[:password],									
				:password_confirmation => params[:password_confirmation])		
				
	if @user.save								
		session[:user_id] = @user.id 			# saving it if the model is valid. 	
		redirect to('/')						
		
	else 
		flash.now[:errors] = @user.errors.full_messages
		erb :"users/new"	# show the same form again, if the model is not valid. 
	end 
end 

