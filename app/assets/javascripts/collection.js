$(document).ready(function() {

	// searchbox field text
	$('.search').val(function(i, val) {
		val = $(this).attr("field");
		if (val != "") {return val;}
	});
	
	$('.circles').hover(function(){
		$(this).children('.back').fadeIn();
		$(this).children('.front').fadeOut();
	}, function() {
		$(this).children('.back').fadeOut();
		$(this).children('.front').fadeIn();
	});
	
	
	$(document).ajaxError(function(event, request) {
	  var msg = request.getResponseHeader('X-Message');
	  if (msg) alert(msg);
	});
	

	$('.search').focus(function() {
		$(this).val("");
		$(this).css({
			'color' : 'black',
		});
	});

	$('.search').blur(function () {
		if ($(this).val() == "") 
		{
			$(this).val(function(i, val) {
				val = $(this).attr("field");
				return val;
			});
			$(this).css({
				'color' : 'grey',
			});		
		};
	});

	// scrap hover 
	$(".scrap_asset").hover(function() {
		$(this).siblings(".scrap_hover").fadeIn();	
	});
	
	$(".scrap_block").mouseleave(function() {
		$(this).children(".scrap_hover").fadeOut();		
	});
	
	
	// fancybox animation
	$(".fancybox").fancybox({
		'width'				: '65%',
		'height'			: '100%',
		'autoScale'     	: false,
		'type'				: 'iframe',
		'showCloseButton'	: true,	
		'padding'			: '0',	        
	});

	
	$(".fancybox_vb").fancybox({
		'showCloseButton'	: false,
		'titlePosition' 		: 'inside',
	});
	
	
	// price-range slider 
	
	$( "#slider" ).slider({
	range: true,
    min: 1,
    max: 5,
    values: [1, 5],
    slide: function( event, ui ) {
        $( "#amount" ).val(Array(ui.values[0]+1).join("$") + " - " + Array(ui.values[1]+1).join("$") );
    }
    });

});
