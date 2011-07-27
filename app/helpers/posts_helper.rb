module PostsHelper
  
     def votes_for_b
        Vote.where(:voteable_id => id, :voteable_type => "Post", :vote => true).count
      end

      def votes_against_b
        Vote.where(:voteable_id => id, :voteable_type => "Post", :vote => false).count
      end

end
