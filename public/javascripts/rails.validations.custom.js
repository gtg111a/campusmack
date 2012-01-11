clientSideValidations.validators.local["url_format"] = function(element, options) {
  if (!/^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/.test(element.val())) {
    return options.message;
  }
}

clientSideValidations.validators.local["youtube_url_format"] = function(element, options) {
  if (element.val().length > 0 && !/(https?:\/\/(www\.)?youtube\.com\/.*v=\w+.*)|(https?:\/\/youtu\.be\/\w+.*)|(.*src=.https?:\/\/(www\.)?youtube\.com\/v\/\w+.*)|(.*src=.https?:\/\/(www\.)?youtube\.com\/embed\/\w+.*)|(http:\/\/content\.bitsontherun\.com\/players\/.*\.js)/.test(element.val())) {
    return options.message;
  }
}
