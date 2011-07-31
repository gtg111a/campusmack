// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$('a[data-method="delete"]').live('ajax:success', function(){});


/*
jQuery.fn.submitWithAjax = function() {
  this.submit(function() {
   $.post(this.action, $(this).serialize(), null, "script");
    return false;
 });
  return this;
};

$(document).ready(function() {
  ("#new_comment").submitWithAjax();
   return false;
});
*/

//$(document).ready(function() {
//	$("#new_review").submit(function(){
//		$.post($(this).attr("action"), $(this).serialize(), null, "script");
//		return false;
//	})
//})