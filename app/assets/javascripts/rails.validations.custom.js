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

clientSideValidations.formBuilders["ActionView::Helpers::FormBuilder"].remove = function(element, settings) {
  var errorFieldClass = 'field_with_errors',
      inputErrorField = element.closest('.' + errorFieldClass),
      label = jQuery('label[for="' + element.attr('id') + '"]:not(.message)'),
      labelErrorField = label.closest('.' + errorFieldClass);

  if (inputErrorField[0]) {
    inputErrorField.find('#' + element.attr('id')).detach();
    inputErrorField.replaceWith(element);
    label.detach();
    labelErrorField.replaceWith(label);
  }
};

clientSideValidations.validateForm = function(form) {
  var validators = window[form[0].id];
  var valid = true;

  form.trigger('form:validate:before').find('[data-validate]:input').each(function() {
    if (!$(this).isValid(validators)) { valid = false; }
  });

  if (valid) {
    form.trigger('form:validate:pass');
  } else {
    form.trigger('form:validate:fail');
  }

  form.trigger('form:validate:after');
  return valid;
};
