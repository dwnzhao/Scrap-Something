$(document).ready(function() {

	$('.carousel').carousel({interval: 4000});

	// searchbox animation
	var newWidth = $('.search').outerWidth() + 10 + (15 * 2);
	var orgWidth = $('.search').outerWidth()

	$('.search').val(function(i, val) {
		val = $(this).attr("field");
		if (val != "") {return val.toUpperCase();}
		
	});

	$('.search').focus(function() {
		if ($('#search_home').val() == "") {$(this).animate({width: newWidth})};
		$(this).val("");
		$('input:text').css({
			'color' : 'black',
		});
	});


	$('.search').blur(function () {
		if ($('.search').val() == "") 
		{
			$('.search').val(function(i, val) {
				val = $(this).attr("field");
				return val.toUpperCase();
			});
			$('input:text').css({
				'color' : 'grey',
			});		
		};
	});

	// scrap hover 
	$(".scrap_block").hover(function() {
		$(this).children(".edit_icon").fadeIn();		
	}, function() {
		$(this).children(".edit_icon").fadeOut();		
	});

	// fancybox animation
	$(".fancybox").fancybox({
		'width'				: '65%',
		'height'			: '65%',
		'autoScale'     	: false,
		'type'				: 'iframe',
		'showCloseButton'	: true,	
		'padding'			: '0',	        
		helpers : {
			overlay : {
				css : {'background' : 'rgba(0, 0, 0, 0.5)'}
			}
		}
	});



});
