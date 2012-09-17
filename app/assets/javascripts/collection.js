$(document).ready(function() {
	var my_collection_visible = true;
	var bookmarked_collection_visible = true;
	var newWidth = $('#search').outerWidth() + 40 + (15 * 2);
	var orgWidth = $('#search').outerWidth()
	
	var searchBox  = document.getElementById("search");

	if(searchBox) {
		searchBox.value   = "search for ideas";

		searchBox.onfocus = function() {
			if ( searchBox.value == "search for ideas") {
				$("#search").animate({width: newWidth});
				searchBox.value = "";
			}
		};

		searchBox.onblur   = function () {
			if ( searchBox.value == "") {
				$("#search").animate({width: orgWidth});
				searchBox.value  = "search for ideas";
			}
		};
	};

	$("#filter_my_collection").click(function() {
		if (bookmarked_collection_visible) {
		$(".bookmarked_scrap").slideUp();
		bookmarked_collection_visible = false;
		}	
		else {
		$(".bookmarked_scrap").slideDown();
		bookmarked_collection_visible = true;
		}
		
	});

	$("#filter_bookmarked_collection").click(function() {
		if (my_collection_visible) {
		$(".my_scrap").slideUp();
		my_collection_visible = false;
		}
		else {
		$(".my_scrap").slideDown();		
		my_collection_visible = true;
	}
	});
	
	$('.delete_text').hide().removeClass('delete_text').addClass('text-js');

	$('.thumb_to_delete').hover(function(){
	    $(this).find('.text-js').fadeToggle();
	});

	$('.scrap_name').hide().removeClass('scrap_name').addClass('text-js');

	$('.scrap_photo').hover(function(){
	    $(this).find('.text-js').fadeToggle();
	});
	
	$('.mosaic-block').mosaic({opacity:0, animation	:	'slide',	//fade or slide
						anchor_y	:	'top'		//Vertical anchor position
	});	
	
	$(".mosaic-backdrop a").fancybox({
		'width'				: '75%',
		'height'			: '75%',
        'autoScale'     	: false,
        'transitionIn'		: 'none',
		'transitionOut'		: 'none',
		'type'				: 'iframe',
		'showCloseButton'	: true,	
	});		
		
});
