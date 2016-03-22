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

// Write the CSS 'left' value to a span.
function leftValue ( handle ) {
  return handle.parentElement.style.left;
}

var lowerValue = document.getElementById('lower-value'),
  lowerOffset = document.getElementById('lower-offset'),
  upperValue = document.getElementById('upper-value'),
  upperOffset = document.getElementById('upper-offset'),
  handles = connectSlider.getElementsByClassName('noUi-handle');
// Display the slider value and how far the handle moved
// from the left edge of the slider.
connectSlider.noUiSlider.on('update', function ( values, handle ) {
  if ( !handle ) {
    lowerValue.innerHTML = values[handle];
  } else {
  }
});
};
$( "input#distance_slider" ).on( "click",  function( event ) {
  event.stopImmediatePropagation();
  var value = '',
  		clean = '';
  var connectSlider = document.getElementById('nonlinear');
  value = connectSlider.noUiSlider.get();
  var clean = value.split(' ')[0]
$('#distance').val(clean)
  $('#search_form').submit();
});
APP.slider();
});