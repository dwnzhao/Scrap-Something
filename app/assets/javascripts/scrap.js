$(document).ready(function() {

	// delete scrap dialog box
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

	$('.close_dialog').bind('click', function() {
		$(".dialog").dialog("close");
		$("#holder").removeClass("Overlay");
	});
	
	
});