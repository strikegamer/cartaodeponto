# Methods added to this helper will be available to all templates in the application.


module ApplicationHelper	
	
    def gravatar_url_for(email, size = 100)
      return "http://www.gravatar.com/avatar.php?size=#{size}&gravatar_id=#{Digest::MD5.hexdigest(email)}&default=http://dl.getdropbox.com/u/448991/gravatar.jpg"
    end
       
		 
	   def avatar_for(user, options = {:alt => user})
	 	 image_tag gravatar_url_for(user), options
	   end
	   
	 

end
