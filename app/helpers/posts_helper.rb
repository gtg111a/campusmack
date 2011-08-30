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
        :voteable_id => voteable.id
    ).map(&:destroy)
  end

  def post_voted_on?(voteable)
    @user = current_user
    0 < Vote.where(
        :voter_id => @user.id,
        :voter_type => @user.class.name,
        :voteable_id => voteable.id
    ).count
  end

  def youtube_embed(youtube_url, large = false)
    if youtube_url =~ /youtube|youtu.be/
      if youtube_url[/youtu\.be\/([^\?]*)/]
        youtube_id = $1
      else
        # Regex from # http://stackoverflow.com/questions/3452546/javascript-regex-how-to-get-youtube-video-id-from-url/4811367#4811367
        youtube_url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
        youtube_id = $5
      end
      return raw %Q{<iframe title="YouTube video player" width="#{large ? 500 : 200}" height="#{large ? 400 : 200}" src="http://www.youtube.com/embed/#{ youtube_id }" frameborder="0" allowfullscreen></iframe>}
    end
  end

  def vote_buttons(post, size = :large)
    imgwidth = {}
    imgwidth = { :width => 23 } if size == :small
    html = '<div class="vote">'
    html << %Q{<span>#{link_to image_tag('arrow-up.png', imgwidth), vote_up_post_path(post), :method => :post, :remote => true}</span>} if can? :create, Vote
    html << %Q{<span id="vote_count_up#{post.id}">#{post.votes_for_b}</span>}
    html << %Q{<span>#{link_to image_tag('arrow-down.png', imgwidth), vote_down_post_path(post), :method => :post, :remote => true}</span>} if can? :create, Vote
    html << %Q{<span id="vote_count_down#{post.id}">#{post.votes_against_b}</span>}
    html << '</div>'
    raw(html)
  end

end
