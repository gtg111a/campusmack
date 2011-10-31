clientSideValidations.validators.local["url_format"] = function(element, options) {
  if (!/^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/.test(element.val())) {
    return options.message;
  }
}

clientSideValidations.validators.local["youtube_url_format"] = function(element, options) {
  if (element.val().length > 0 && !/((http|ftp)\:\/\/)?([w]{3}\.)?(youtube\.)([a-z]{2,4})(\/watch\?v=)([a-zA-Z0-9_-]+)(\&feature=)?([a-zA-Z0-9_-]+)?/.test(element.val())) {
    return options.message;
  }
}
