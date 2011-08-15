// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$('a[data-method="delete"]').live('ajax:success', function(){});

$(function(){
	$('div#photo_post').click(function(){
		$(this).find("#small_photo").toggle("slow");
		$(this).find("#large_photo").toggle("slow");
		});
   });

$(function() {
  if (document.all&&document.getElementById) {
  navRoot = document.getElementById("nav");
  for (i=0; i<navRoot.childNodes.length; i++) {
  node = navRoot.childNodes[i];
  if (node.nodeName=="LI") {
  node.onmouseover=function() {
  this.className+=" over";
   };
  node.onmouseout=function() {
  this.className=this.className.replace(" over", "");
   };
   }
  }
 }
});

$(function() {
$("ul#post_fields").change(function() {
	if ($("ul#post_fields option[value='Video']").attr('selected')) {
		$(this).find("#video_post").show();
		$(this).find("#photo_post").hide();
				}
	else if ($("ul#post_fields option[value='Photo']").attr('selected')) {
			 $(this).find("#video_post").hide();
			 $(this).find("#photo_post").show();
				}
	else {
		$(this).find("#video_post").hide();
		$(this).find("#photo_post").hide();
		 }
	        });
	      });
