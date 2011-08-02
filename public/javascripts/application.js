// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$('a[data-method="delete"]').live('ajax:success', function(){});

$(function(){
	//$('img#post_pic').click(function(){
	//	$(this).remove()
	//	});
	$('div#photo_post').click(function(){
		$(this).find("#small_photo").toggle("slow");
		$(this).find("#large_photo").toggle("slow");
		});
		//$(this 'img#small_photo').css('display','none')
   });

