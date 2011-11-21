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

  def youtube_embed(youtube_url, size = :small)
    if youtube_url =~ /youtube|youtu.be|y2u.be/
      if youtube_url[/(y2u|youtu)\.be\/([^\?]*)/]
        youtube_id = $2
      else
        # Regex from # http://stackoverflow.com/questions/3452546/javascript-regex-how-to-get-youtube-video-id-from-url/4811367#4811367
        youtube_url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
        youtube_id = $5
      end
      case size
        when :small
          w = 173
          h = 101
        when :medium
          w = 217
          h = 163
        when :large
          w = 500
          h = 400
        else
          w = 173
          h = 101
      end
      # generate random hex for youtube id uniqueness
      random = ActiveSupport::SecureRandom.hex(6)
      return raw %Q{<div id="ytplayer-#{youtube_id + random}"><h3>To see this content Flash player is required.<a href="http://get.adobe.com/flashplayer/" title="Get the latest version">Get the latest version.</a></h3></div><script type="text/javascript">var params = { allowScriptAccess: "always", wmode:"opaque" };var atts = { id: "ytplayer-#{youtube_id + random}" };swfobject.embedSWF("http://www.youtube.com/e/#{youtube_id}?enablejsapi=1&playerapiid=ytplayer","ytplayer-#{youtube_id + random}", "#{w}", "#{h}", "9", "/expressInstall.swf", null, params, atts);</script>}

    end
  end

  def vote_buttons(post, size = :large)
    imgwidth = { }
    imgwidth = { :width => 23 } if size == :small
    tag = size == :small ? 'span' : 'div';
    html = %Q{<#{tag} class="vote">}
    html << %Q{<#{tag} class="vote_title">Votes:</#{tag}>}
    html << %Q{<#{tag} class="vote_value">}
    html << %Q{<span id="vote_count_up#{post.id}">#{post.up_votes}</span>}
    html << link_to(image_tag('arrow-up.png', imgwidth), vote_up_post_path(post), :method => :post, :remote => true, :class => "vote-up") if can? :create, Vote
    html << "</#{tag}>"
    html << %Q{<#{tag} class="vote_title">Against:</#{tag}>}
    html << %Q{<#{tag} class="vote_value">}
    html << %Q{<span id="vote_count_down#{post.id}">#{post.down_votes}</span>}
    html << link_to(image_tag('arrow-down.png', imgwidth), vote_down_post_path(post), :method => :post, :remote => true, :class => "vote-down") if can? :create, Vote
    html << "</#{tag}></#{tag}>"
    raw(html)
  end

end
