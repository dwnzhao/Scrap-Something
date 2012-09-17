$(document).ready(function() {

	$( ".dialog" ).dialog({
		closeOnEscape: true,
		closeText: '',
		autoOpen: false,
		show: "blind", 
		hide: "blind",
	});

	$( "#delete_scrap" ).click(function() {
		$( "#dialog_scrap" ).dialog( "open" );
		$("#holder").addClass("Overlay");
		return false;
	});

	$( ".thumb_to_delete" ).click(function() {
		$("#dialog_icon").dialog( "open" );
		$("#holder").addClass("Overlay");
		return false;
	});

	$('.close_dialog').bind('click', function() {
		$(".dialog").dialog("close");
		$("#holder").removeClass("Overlay");
	});


});