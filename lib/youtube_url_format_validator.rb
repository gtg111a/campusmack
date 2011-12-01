class YoutubeUrlFormatValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    unless value.nil? || value.empty? || value =~ /(https?:\/\/(www\.)?youtube\.com\/.*v=\w+.*)|(https?:\/\/youtu\.be\/\w+.*)|(.*src=.https?:\/\/(www\.)?youtube\.com\/v\/\w+.*)|(.*src=.https?:\/\/(www\.)?youtube\.com\/embed\/\w+.*)/
      object.errors.add(attribute, :youtube_url_format, options)
    end
  end
end
