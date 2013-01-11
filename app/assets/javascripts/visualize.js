$(function() {
	var vb_left_margin = 450;
	var vb_top_margin = 100;
	var vb_background_color = "#FFF";
	var vb_background_border_color = "#D6A44B";
	var vb_background_border_width = 4;
	
	var vb_page_top_margin = 70;
	var vb_height = 300;
	var vb_width = 480;
	
	
	$( "#catalog li img" ).draggable({
		helper: "clone",
	});
	// 

	function convert_to_image() {
		var c=document.getElementById("myCanvas");
		var ctx=c.getContext("2d");
		ctx.clearRect(0, 0, c.width, c.height);
		ctx.fillStyle = vb_background_color;
		ctx.fillRect(0, 0, c.width, c.height);

		ctx.strokeStyle = vb_background_border_color;
		ctx.lineWidth   = vb_background_border_width;		
		ctx.strokeRect(2, 2, c.width - vb_background_border_width, c.height - vb_background_border_width);

		$(".big").each(function() {
			var left = $(this).parent().offset().left - vb_left_margin;
			var top = $(this).parent().offset().top - vb_top_margin;
			var width = $(this).parent().width();
			var height = $(this).parent().height();
			var img = $(this);
			ctx.drawImage(img[0],left,top, width, height);
		});

		return c.toDataURL();
	};

	$( "#vision_board" ).droppable({
		accept: "#catalog li img",
		drop: function( event, ui ) {
			$(this).find( ".placeholder" ).remove();
			$(".big").parent().css("z-index", "1");
	
			
			ui.draggable.clone().prependTo("#image-area" ).wrap('<div class="image">');
			$(".image").children(".small").removeClass("small").addClass("big top");
			
			var left = $("#vision_board").offset().left;
			var top = $("#vision_board").offset().top + vb_page_top_margin;

			var right = $("#vision_board").offset().left + vb_width;
			var bottom = $("#vision_board").offset().top + vb_height;

			$(".big").resizable().parent().draggable({
				containment: [left, top, right, bottom ],
				start: function() {		
					$(".big").parent().css("z-index", "3");
					$(this).css("z-index", "10");
				}
			});
			
			$(".top").parent().css("z-index", "100").children(".top").removeClass("top");
			
		}
	});

	$("#confirm_save").click(function() {

		var dataURL = convert_to_image();

		var form = '<div style="padding: 30px"><input id="vb_name" placeholder="name your vision board..." class="txt" /><br><hr><br><img style="width:150px; height:150px" src="'+dataURL+'"/><br><br><button class="button" id="save_vision_board">save</button></div>'

		$.fancybox(
			form,
			{
				'width'				: '80%',
				'height'			: '80%',
				'autoScale'     	: false,
				'showCloseButton'	: true,	
				'padding'			: '0',	 
			});

			$("#save_vision_board").click(function() {						
				var dataURL = convert_to_image().replace("data:image/png;base64,", "");    

				$.ajax({ url: '/visualize/save',
				type: 'POST',
				beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
				data: {img_url: dataURL, vb_name: $('#vb_name').val()},
				success: function(data, textStatus) {
					if (data.redirect) {
						window.location.href = data.redirect;
					}
				}
			});

		});
	});


	$("#export").click(function() {		

		var dataURL = convert_to_image();
		var img = '<img style="width:700px; height:600px" src="'+dataURL+'"/>'

		$.fancybox(
			img,
			{
				'width'				: '80%',
				'height'			: '80%',
				'autoScale'     	: false,
				'showCloseButton'	: true,	
				'padding'			: '0',	        
			}
		);
	});	

});
