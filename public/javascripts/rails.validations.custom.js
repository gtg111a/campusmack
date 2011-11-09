clientSideValidations.validators.local["url_format"] = function(element, options) {
  if (!/^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/.test(element.val())) {
    return options.message;
  }
}

clientSideValidations.validators.local["youtube_url_format"] = function(element, options) {
  if (element.val().length > 0 && !/(htt(p|ps):\/\/|^)(?:(youtu|y2u)\.be\/|(?:[a-z]{2,3}\.)?youtube\..{1,4}\/watch(?:\?|#\!)v=)([\w-]{11}).*/.test(element.val())) {
    return options.message;
  }
}
