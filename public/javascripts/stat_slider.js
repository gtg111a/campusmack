$(document).ready(function(){
  var currentPosition = 0;
  var slideWidth = 124;
  var slides = $('.inbox_table');
  var numberOfSlides = slides.length;

  // Remove scrollbar in JS
  $('#stats_container').css('overflow', 'hidden');

  // Wrap all .slides with #slideInner div
  slides
  .wrapAll('<div id="slideInner"></div>')
  // Float left to display horizontally, readjust .slides width
  .css({
    'float' : 'left',
    'width' : slideWidth
  });

  // Set #slideInner width equal to total width of all slides
  $('#slideInner').css('width', slideWidth * numberOfSlides);

  // Insert left and right arrow controls in the DOM
  $('#stats_widget')
    .prepend('<div class="control" id="left_arrow"></div>')
    .append('<div class="control" id="right_arrow"></div>');

  // Hide left arrow control on first load
  manageControls(currentPosition);

  // Create event listeners for .controls clicks
  $('.control')
    .bind('click', function(){
    // Determine new position
      currentPosition = ($(this).attr('id')=='right_arrow')
    ? currentPosition+1 : currentPosition-1;

      // Hide / show controls
      manageControls(currentPosition);
      // Move slideInner using margin-left
      $('#slideInner').animate({
        'marginLeft' : slideWidth*(-currentPosition)
      });
    });

  // manageControls: Hides and shows controls depending on currentPosition
  function manageControls(position){
    // Hide left arrow if position is first slide
    if(position==0){ $('#left_arrow').hide() }
    else{ $('#left_arrow').show() }
    // Hide right arrow if position is last slide
    if(position==numberOfSlides-1){ $('#right_arrow').hide() }
    else{ $('#right_arrow').show() }
    }
  });