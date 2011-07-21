module ApplicationHelper
	#Return a title on a per-page basis
	def logo
    	image_tag("Smack That", :class => "round")
    end
    
	def title
		base_title = "Campus Smack"
		if @title.nil?
			base_title
		else
			"#{base_title} | #{@title}"
end
end
end