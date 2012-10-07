$(document).ready(function() {

	// searchbox animation
	var newWidth = $('.search').outerWidth() + 10 + (15 * 2);
	var orgWidth = $('.search').outerWidth()


	$('#search_explore').val("search for ideas");
	$('#search_home').val("search my stuff");

	$('input:text').css({
		'font-size' : '11px',
		'color' : 'grey',
		'outline' : 'none',
		'cursor' : 'text'
	});

	$('.search').focus(function() {
		if ($('#search_explore').val() == "search for ideas") 
		{
			$(".search").animate({width: newWidth});
			$('#search_explore').val("");
		}
		
		if ($('#search_home').val() == "search my stuff") 
		{
			$(".search").animate({width: newWidth});
			$('#search_home').val("");
		}

		$('input:text').css({
			'color' : 'black',
		});
	});


	$('.search').blur(function () {
		if ($('#search_explore').val() == "") 
		{
			$(".search").animate({width: orgWidth});
			$('#search_explore').val("search for ideas");
			$('input:text').css({
				'color' : 'grey',});
		};
		
		if ($('#search_home').val() == "") 
		{
			$(".search").animate({width: orgWidth});
			$('#search_home').val("search my stuff");
			$('input:text').css({
				'color' : 'grey',});
		};
	});
	

	// collection toggle
	var my_collection_visible = true;
	var bookmarked_collection_visible = true;

	$("#filter_my_collection").toggle(function() {
		$(".bookmarked_scrap").slideUp();
	}, function() {
		$(".bookmarked_scrap").slideDown();
	});

	$("#filter_bookmarked_collection").toggle(function() {
		$(".my_scrap").slideUp();
	}, function() {
		$(".my_scrap").slideDown();		
	});

	// scrap hover 
	$(".scrap_block").hover(function() {
		$(this).children(".scrap_edit").fadeIn();		
	}, function() {
		$(this).children(".scrap_edit").fadeOut();		
	});


	// scrap detail iframe
	$(".scrap_asset a").fancybox({
		'width'				: '65%',
		'height'			: '65%',
		'autoScale'     	: false,
		'transitionIn'		: 'none',
		'transitionOut'		: 'none',
		'type'				: 'iframe',
		'showCloseButton'	: true,	
	});	

	// menu

	$('#account_menu').toggle(
		function () {$('#account_menu_expand').slideDown(100);},
		function () {$('#account_menu_expand').slideUp(100);
		}	
	);
	
	$('#add_menu').toggle(
		function () {$('#add_menu_expand').slideDown(100);},
		function () {$('#add_menu_expand').slideUp(100);
		}	
	);


});
