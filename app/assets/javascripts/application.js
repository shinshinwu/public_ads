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
	  start: 5,
	  step: .25,
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
	;APP.getCoordsFromNewListing = function() {
			var newListingGeoData = {};
				newListingGeoData['panoLat'] =newOOHM.panorama.getPosition().lat();
				newListingGeoData['panoLng'] =newOOHM.panorama.getPosition().lng();
				newListingGeoData['panoId'] = newOOHM.panorama.getPano();
				newListingGeoData['heading'] = newOOHM.panorama.getPov().heading;
				newListingGeoData['pitch'] = newOOHM.panorama.getPov().pitch;
				return newListingGeoData;
			// alert('panoCoords: ' + panoCoords + 'panoId: ' + panoId+ 'heading: ' + heading + 'pitch: ' + pitch);
		
	}
	;APP.getPanoFromNewListing = function() {
	}
	;APP.getImgFromNewListing = function() {
	}
	;APP.bindCoordsFromNewListingToForm = function() {
	}
	;APP.bindPanoFromNewListingToForm = function() {
	}
	;APP.bindImgFromNewListingToForm = function() {
	}
	;$( "input#distance_slider" ).on( "click",  function( event ) {
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
$("input#stopy").on("click", function(event){
	event.stopImmediatePropagation();
	if (newOOHM.panorama) {
		var newListingGeoData = APP.getCoordsFromNewListing();
		$('#pano_id_field').val(newListingGeoData['panoId']);
		$('#pano_heading').val(newListingGeoData['heading']);
$('#pano_pitch').val(newListingGeoData['pitch']);
$('#pano_lat').val(newListingGeoData['panoLat']);
$('#pano_lng').val(newListingGeoData['panoLng']);
		$('input#stopy').submit();
		}	
	// alert(newListingGeoData['panoCoords']);
// $('input#stopy :input:visible[required="required"]').each(function() {
//     if(!this.validity.valid) { 
//   		$(this).focus();
//       return false;
//     }
// });

	
	// alert('hit the button breh. im listening.');
});
$('.cta-link').smoothScroll({
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


$('#joinLink').click(function() {
    $('#tab-two-panel > .toggleable').toggle();
    $(this).text(function(i,txt) {
        return txt === "Sign In" ? "Sign Up" : "Sign In";
    });
});

$(document).on('click',function(){
	$('.collapse').collapse('hide');
})



	APP.slider();
});
