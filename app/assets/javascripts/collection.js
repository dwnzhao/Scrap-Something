$(document).ready(function() {

	$('.carousel').carousel({interval: 4000});

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
		$(this).animate({width: newWidth});
		$(this).val("");
		$('input:text').css({
			'color' : 'black',
		});
	});


	$('.search').blur(function () {
		if ($('#search_explore').val() == "") 
		{
			$(this).animate({width: orgWidth});
			$(this).val("search for ideas");
			$('input:text').css({'color' : 'grey',});
		};

		if ($('#search_home').val() == "") 
		{
			$(this).animate({width: orgWidth});
			$(this).val("search my stuff");
			$('input:text').css({
				'color' : 'grey',});
			};
		}
	);
	
	$('.dropdown-menu').find('form').click(function (e) {
    e.stopPropagation();
  });
  

	// scrap hover 
	$(".scrap_block").hover(function() {
		$(this).children(".edit_icon").fadeIn();		
	}, function() {
		$(this).children(".edit_icon").fadeOut();		
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
				css : {'background' : 'rgba(0, 0, 0, 0.5)'}
			}
		}
	});	
	
	$(".scrap_edit").fancybox({
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
				css : {'background' : 'rgba(0, 0, 0, 0.5)'}
			}
		}
	});



});
