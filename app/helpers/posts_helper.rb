module PostsHelper
  
     def votes_for_b
        Vote.where(:voteable_id => id, :voteable_type => "Post", :vote => true).count
      end

      def votes_against_b
        Vote.where(:voteable_id => id, :voteable_type => "Post", :vote => false).count
      end
      
      def post_type(college, type)
        if type == "Video"
        return college.posts.where(:content_type =>"Video")
      elsif type == "Pic"
        return college.posts.where(:content_type => "Pic")
      else
        return college.posts.all  
      end
    end

end
