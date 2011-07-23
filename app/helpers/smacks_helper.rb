module SmacksHelper
  
    def youtube_embed(youtube_url)
      if youtube_url =~ /youtube|youtu.be/
        if youtube_url[/youtu\.be\/([^\?]*)/]
          youtube_id = $1
        else
        # Regex from # http://stackoverflow.com/questions/3452546/javascript-regex-how-to-get-youtube-video-id-from-url/4811367#4811367
        youtube_url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
        youtube_id = $5
      end
        return %Q{<iframe title="YouTube video player" width="200" height="200" src="http://www.youtube.com/embed/#{ youtube_id }" frameborder="0" allowfullscreen></iframe>}
    else
      return ""
    end   
  end
end
