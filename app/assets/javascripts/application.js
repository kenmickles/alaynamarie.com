// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require_tree .

App = {
	
	autoslide_id: null,
	photo_width: null,
	photo_count: null,
	
	start_slideshow: function() {
		if ( !App.autoslide_id ) {
			App.autoslide_id = setInterval("$('a.next').click();", 2500);
		}
	},
	
	stop_slideshow: function() {
		if ( App.autoslide_id ) {
			clearInterval(App.autoslide_id);
		}
	},
	
	slide_to: function(photo, animated) {
		// should we animate the slide?
		if ( typeof(animated) == 'undefined' ) {
			animated = true;
		}
		
		// the sliding canvas
		var $ul = $('#slider ul');
		
		// if the slider is already animated, we drop this slide
		if ( $ul.is(':animated') ) {
			return;
		}
		
		// calculate the left position to view the full photo
		left = photo * (App.photo_width * -1);
	
		// don't allow scrolling out of the bounds of the slider
		if ( left > 0 ) {
			left = ($ul.width() - App.photo_width) * -1;
			photo = App.photo_count - 1;
		}
		else if ( left < (($ul.width() - App.photo_width) * -1) ) {
			left = 0;
			photo = 0;
		}

		// slide the photos to the correct position
		if ( animated ) {
			$ul.animate({
				marginLeft: left + 'px'
			}); 
		}
		else {
			$ul.css('margin-left', left + 'px');
		}
	
		// and update the slide bar accordingly
		$('#slide-bar').slider('option', 'value', (photo * 400));
		
		// update location bar
		location.hash = '#photo' + (photo + 1);		
	},
	
	init: function(controller) {
		if ( controller == 'Books' ) {			
			App.photo_count = $('#photos li').length;
			App.photo_width = $('#photos li:first').width();
			
			// add faux-:hover states for slider div
			$('#slider').hover(function(){
				$(this).addClass('hover');
			}, function(){
				$(this).removeClass('hover');
			});
			
			// add keyboard controls
			$(document).keyup(function(e) {
				// left arrow or up arrow goes back
			  if ( e.keyCode == 37 || e.keyCode == 38 ) { 
					$('a.prev').click();
				}
				// right arrow, down arrow, or space goes to the next page
				else if ( e.keyCode == 39 || e.keyCode == 40 || e.keyCode == 32 ) {
					$('a.next').click();
				}
			});				
	
			// set up the slider control
			$("#slide-bar").slider({
				// update photo position as the slider is moved
				slide:function(e, ui){
					$('#slider ul').css('margin-left', -Math.round(ui.value * App.photo_width / 400 ) + 'px');
				},
			
				// 400 ticks for each extra package
				max: ((App.photo_count-1) * 400),
				step: 1
			});
			
			// if we've got a #photo<NUM> hash, show that photo
			if ( location.hash.match(/^#photo/) ) {
				// but first subtract 1 (our photo array starts with 0, but the urls start with 1)
				var photo_num = location.hash.replace(/^#photo/, '') - 1;
				// slide to the correct photo without an animation
				App.slide_to(photo_num, false);
			}
		
			// slider arrow links
			$('a.next, a.prev').click(function(){
				// the slider canvas
				var $ul = $('#slider ul');
	
				// if the slider is already animating, we just drop the click
				if ( $ul.is(':animated') ) {
					return false;
				}
				
				// calculate the initial left position
				var left = parseInt($ul.css('margin-left').replace(/px$/, ''));
			
				// find the closest photo
				var current_photo = Math.floor((left * -1) / App.photo_width);

				// if this is a next link, we move the margin a photo width to the left
				if ( $(this).is('.next') ) {
					var next_photo = current_photo + 1;
				}
				// otherwise, it's a prev link. we move those a photo width to the right
				else {
					var next_photo = current_photo - 1;
				}
				
				// slide to the correct photo
				App.slide_to(next_photo);

				// avoid the browser navigating to #
				return false;
			});
		
			//  App.start_slideshow();
		
		} // end books/show
	}
	
};
