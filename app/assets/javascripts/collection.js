$(document).ready(function() {

	var searchBox      = document.getElementById("search");
	var dialog_present = document.getElementById("dialog");

	if(searchBox) {
		searchBox.value   = "search for ideas";

		searchBox.onfocus = function() {
			if ( searchBox.value == "search for ideas") {
				searchBox.value = "";
			}
		};

		searchBox.onblur   = function () {
			if ( searchBox.value == "") {
				searchBox.value  = "search for ideas";
			}
		};
	};

	if(dialog_present) { 
		$( "#dialog" ).dialog({
			closeOnEscape: true,
			closeText: '',
			autoOpen: false,
			show: "drop", 
		});

		$( "#delete_scrap" ).click(function() {
			$( "#dialog" ).dialog( "open" );
			$("#holder").addClass("Overlay");
			return false;
		});
	};

	if(dialog_present) { 
		$( "#dialog" ).dialog({
			closeOnEscape: true,
			closeText: '',
			autoOpen: false,
			show: "drop", 
			
		});

		$( "#scrap_image" ).click(function() {
			$( "#dialog" ).dialog( "open" );
			$("#holder").addClass("Overlay");
			return false;
		});
	};

	$("#filter_all").click(function() {
		$(".my_scrap").css("display","block");
		$(".bookmarked_scrap").css("display", "block");	
	});

	$("#filter_my_collection").click(function() {
		$(".my_scrap").css("display","block");
		$(".bookmarked_scrap").css("display", "none");	
	});

	$("#filter_bookmarked_collection").click(function() {
		$(".my_scrap").css("display","none");
		$(".bookmarked_scrap").css("display", "block");	
	});
	
	$('.delete_text').hide().removeClass('delete_text').addClass('text-js');

	$('.thumb_to_delete').hover(function(){
	    $(this).find('.text-js').fadeToggle();
	});

	$('.scrap_name').hide().removeClass('scrap_name').addClass('text-js');

	$('.scrap_photo').hover(function(){
	    $(this).find('.text-js').fadeToggle();
	});
});
