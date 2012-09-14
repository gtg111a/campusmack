// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require custom
//= require rails.validations
//= require rails.validations.custom
//= require twipsy
//= require fancybox/jquery.fancybox-1.3.4.pack.js
//= require jquery.toastmessage.js
//= require jquery.tokeninput.js
//= require jquery.infinitescroll.min.js
//= require facebox
//= require stat_slider
//= require swfobject

$(document).ready(function() {
  if ($('.posts-auto-scroll.auto-scroll').length > 0) {
    $('#posts_auto_scroll_indicator').infinitescroll({
      loading: {
        img: '/assets/ajax-loader.gif',
        msgText: 'Loading more posts...',
        finishedMsg: 'There are no more posts to load.'
      },
      dataType: 'json',
      navSelector: '.posts-auto-scroll .pagination',
      nextSelector: '.posts-auto-scroll .pagination a.next_page',
      template: function(data) {
        return data.posts;
      },
      appendCallback: false,
      bufferPx: 80,
      pathParse: function(path, page) {
        if (path.match(/^(.*?page=)2(\/.*|$)/)) {
          path = path.match(/^(.*?page=)2(\/.*|$)/).slice(1);
          return path;
        }
        return path;
      }
    }, function(data) {
      $('#posts').append(data.posts);
    });
  }
});
