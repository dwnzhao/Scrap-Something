$(function() {
	
	$(".tab_check_box").click(function() {
	
		$("#tab_update").fadeIn();
	});
	
	$("#create_tab_in_scrap_detail").click(function(){

		$("#tab_field").fadeIn();
		$("#tab_update").fadeIn();
		$("#create_tab_in_scrap_detail").fadeOut();
	});
})