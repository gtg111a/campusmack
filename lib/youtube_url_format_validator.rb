class YoutubeUrlFormatValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    unless value.empty? || value =~ /(htt(p|ps):\/\/|^)(?:(youtu|y2u)\.be\/|(?:[a-z]{2,3}\.)?youtube\..{1,4}\/watch(?:\?|#\!)v=)([\w-]{11}).*/
      object.errors.add(attribute, :youtube_url_format, options)
    end
  end
end


