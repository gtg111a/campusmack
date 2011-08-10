module PostsHelper
  
     def votes_for_b
        Vote.where(:voteable_id => id, :voteable_type => "Post", :vote => true).count
      end

      def votes_against_b
        Vote.where(:voteable_id => id, :voteable_type => "Post", :vote => false).count
      end
      
      def vote_check_for(voteable)
        @user = current_user
        if post_voted_on?(voteable)
          clear_votes(voteable)
          @user.vote_for(voteable)
        else
          @user.vote_for(voteable)
        end
      end
      
      def vote_check_against(voteable)
        @user = current_user
        if post_voted_on?(voteable)
          clear_votes(voteable)
          @user.vote_against(voteable)
        else
          @user.vote_against(voteable)
        end
      end
      
      
      def clear_votes(voteable)
          @user = current_user
          Vote.where(
               :voter_id => @user.id,
               :voter_type => @user.class.name,
               :voteable_id => voteable.id,
               ).map(&:destroy)
      end
      
      def post_voted_on?(voteable)
        @user = current_user
          0 < Vote.where(
                :voter_id => @user.id,
                :voter_type => @user.class.name,
                :voteable_id => voteable.id,
              ).count
        end

end
