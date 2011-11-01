class YoutubeUrlFormatValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    unless value.empty? || value =~ /((http|ftp)\:\/\/)?([w]{3}\.)?(youtube\.)([a-z]{2,4})(\/watch\?v=)([a-zA-Z0-9_-]+)(\&feature=)?([a-zA-Z0-9_-]+)?/
      object.errors.add(attribute, :youtube_url_format, options)
    end
  end
end


