// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require bootstrap-sprockets
//= require turbolinks
//= require_tree .

$(document).ready(function() {
	var APP = {};
	;APP.slider = function(){
	var connectSlider = document.getElementById('nonlinear');
	APP.instance = noUiSlider.create(connectSlider, {
	  connect: 'lower',
	  behaviour: 'tap',
	  start: 1,
	  range: {
	    'min': [ 0 ],
	    'max': [ 10 ]
	  },
	  format: wNumb({
	  decimals: 2,
	  postfix: '  miles'
	  })
	});
	if (gon.distance) {
		connectSlider.noUiSlider.set(gon.distance);
	}
	function distanceValue ( handle ) {
	  return handle.parentElement.style.left;
	}
	var distanceVal = document.getElementById('distance-value'),
	  handles = connectSlider.getElementsByClassName('noUi-handle');
		connectSlider.noUiSlider.on('update', function ( values, handle ) {
		  if ( !handle ) {
		    distanceVal.innerHTML = values[handle];
		  } else {
		  }
		});
	};
	$( "input#distance_slider" ).on( "click",  function( event ) {
	  event.stopImmediatePropagation();
	  var inputValue = '',
	  		distanceInMiles = '';
	  var connectSlider = document.getElementById('nonlinear');
			  inputValue = connectSlider.noUiSlider.get();
	  var distanceInMiles = inputValue.split(' ')[0];
		$('#distance').val(distanceInMiles);
	  $('#search_form').submit();
	});

// $('body').smoothScroll({
//         delegateSelector: 'ul.mainnav li a'
//       });
$('.linka').smoothScroll({
			offset: -150,
		  beforeScroll: function(options) {
		    var newItemID = options.scrollTarget;
		    var someItem = $( "input[checked]" );
		    $(someItem).prop( "checked", false);
		    console.log(someItem.attr('id'));
		    var newElement = $(newItemID);
		    $(newElement).prop( "checked", true )
		  }
		});

	APP.slider();
});
