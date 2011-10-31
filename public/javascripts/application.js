// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// Twipsy is used by validation of user model, in sign in/sign up views.
$(function() {
    $('div[rel=twipsy]').twipsy({
       'placement': 'above',
        'title': function() { return $(this).find('.message').text(); },
        'live': true
    });
});

$('a[data-method="delete"]').live('ajax:success', function(){});

$(function() {
    $(".smack").click(function() {
        jQuery.facebox("<span style='text-align: center;padding-left:45%'><img src='/images/ajax-loader.gif' /></span>")
    });
});

/* This code hides the video/photo field depending on what the user selects */
$(function() {
$("ul#post_fields").change(function() {
	if ($("ul#post_fields option[value='Video']").attr('selected')) {
		$(this).find("#video_field").show();
		$(this).find("#photo_field").hide();
		$(this).find("#news_field").hide();
				}
	else if ($("ul#post_fields option[value='Photo']").attr('selected')) {
			 $(this).find("#video_field").hide();
		     $(this).find("#news_field").hide();
			 $(this).find("#photo_field").show();
				}
	else if ($("ul#post_fields option[value='News']").attr('selected')) {
			 $(this).find("#video_field").hide();
			 $(this).find("#photo_field").hide();
			 $(this).find("#news_field").show();
				}
	else {
		$(this).find("#video_field").hide();
		$(this).find("#photo_field").hide();
		$(this).find("#news_field").hide();
		 }
	        });
	      });
/* This code will show the photo field and video field in the Edit view depending on what type of post it is */
$(function() {
	if ($("ul#post_fields option[value='Video']").attr('selected')) {
		$("#video_field").show();
		}
	else if ($("ul#post_fields option[value='Photo']").attr('selected')) {
		$("#photo_field").show();
			}
	else if ($("ul#post_fields option[value='News']").attr('selected')) {
		$("#news_field").show();
			}
		});
		
/* This code is to activate the Fancybox plugin for photos. */
function formatTitle() {
    return '<div id="photo-close"><span><a href="javascript:;" onclick="$.fancybox.close();"><img src="/images/fancybox/fancy_close.png" /></a></span></div>';
}
$(function() {

	/* This is basic - uses default settings */
	
	
	$("a.photo").fancybox({
		'showCloseButton'	: false,
		'titlePosition' 	: 'outside',
		'titleFormat'		: formatTitle
		});
	
	/* Using custom settings */
	
	$("a#inline").fancybox({
		'hideOnContentClick': true
	});

	/* Apply fancybox to multiple items */
	
	$("a.group").fancybox({
		'transitionIn'	:	'elastic',
		'transitionOut'	:	'elastic',
		'speedIn'		:	600, 
		'speedOut'		:	200, 
		'overlayShow'	:	false
	});
	
});

$(document).ready(function() {
 setEqualHeight($("#basic_content .column"));
});

function setEqualHeight(columns)
 {
 var tallestcolumn = 0;
 columns.each(
 function()
 {
 currentHeight = $(this).height();
 if(currentHeight > tallestcolumn)
 {
 tallestcolumn  = currentHeight;
 }
 }
 );
 columns.height(tallestcolumn);
 }

