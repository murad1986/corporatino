// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.datepicker-ru
//= require jquery-ui
//= require twitter/bootstrap
//= require tableSorter
//= require best_in_place
//= require_self

$(function(){
  $(".zebra-striped").tablesorter();
  $(".best_in_place").best_in_place();
  $(".best_in_place").each(function (index,el) {
    var val = $(el).parent().attr("name");
    if(val){$(el).html(val);}
  });
  $('.dropdown').dropdown();
  $('.datepicker').datepicker({ dateFormat: 'yy-mm-dd' });

  var abonents = $("#corporation_abonent_id").html();
  $('#corporation_corporation_id').change(function(){
  	var corporation = $('#corporation_corporation_id :selected').text();
  	// corporation = corporation.replace(/( #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1');
  	var options = $(abonents).filter("optgroup[label='" + corporation + "']").html();
  	if (options) {
  	  $('#corporation_abonent_id').html(options);
  	} else {
  	  $("#corporation_abonent_id").html('');
  	}
  });
  $('#corporation_corporation_id').change();

  if ($('.dynamic_select').length > 0) {
	  var abonents = $("#abonent_payment_abonent_id").html();
	  $('#corporation_corporation_id').change(function(){
	  	var corporation = $('#corporation_corporation_id :selected').text();
	  	// corporation = corporation.replace(/( #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1');
	  	var options = $(abonents).filter("optgroup[label='" + corporation + "']").html();
	  	if (options) {
	  	  $('#abonent_payment_abonent_id').html(options);
	  	} else {
	  	  $("#abonent_payment_abonent_id").html('');
	  	}
	  });
	  $('#corporation_corporation_id').change();
  }
});
