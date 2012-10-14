if (document.getElementById('overlay') == null) {
	$('body').prepend('<div id="overlay"></div>');

	$('img').each(function() {
		var height = $(this).height();
		height = height/2;
		if (height > 50) {
			height *= -1; 
		
		var domain = '';
			
			var src = $(this).attr('src');
			if (!src.match('^http')) {domain = 'http://' + document.domain + '/'}
			
			name = document.domain;
			
			var ins1 = '<div class="scrap_add_instruction" style="position: relative; z-index: 3000; margin-left: auto; margin-right: auto;"><a href="http://localhost:3000/external/add_external_image?img_url=';
			var ins2 = '&name='
			var ins3 = '" target="_blank">Add this image</a></div>';
			var add_instruction_div = ins1 + domain + src + ins2 + name + ins3;


			$(this).parent().removeAttr('href');
			$(this).wrap('<div class="scrap_add" />');
//			alert(add_instruction_div);
			$(this).parent().append(add_instruction_div);
			$(this).parent().children('.scrap_add_instruction').css('top', height);
		}
	});

}

else { 
	$('#overlay').remove();
	$('.scrap_add_instruction').remove();
}

$('.scrap_add_instruction').click(function() {
	$('#overlay').remove();
	$('.scrap_add_instruction').remove();	
});