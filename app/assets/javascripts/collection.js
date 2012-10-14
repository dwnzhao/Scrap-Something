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
			}
		);

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
			'padding'			: '0',	        
			 helpers : {
			        overlay : {
			            css : {
			                'background' : 'rgba(0, 0, 0, 0.5)'
			            }
			        }
			    }
		}
		);	

		// menu

		$('#account_menu').toggle(
			function () {$('#account_menu_expand').slideDown(100);},
			function () {$('#account_menu_expand').slideUp(100);}	
		);

		$('#add_menu').toggle(
			function () {$('#add_menu_expand').slideDown(100);},
			function () {$('#add_menu_expand').slideUp(100);}	
		);

		$("html").click(function() {
			if ($('#account_menu_expand').is(':visible')) {
				$('#account_menu').trigger('click');
			};
			if ($('#add_menu_expand').is(':visible')) {
				$('#add_menu').trigger('click');
			} 
		});



	});
