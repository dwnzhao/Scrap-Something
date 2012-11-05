$('#center_panel_content').html('');

<%if @selected_collection.size == 0%>
$('<div style="margin:30px" class="alert alert-info">sorry, nothing found</div>').appendTo('#center_panel_content').hide().fadeIn('10000');

<%else%>
$('<%= escape_javascript(render(:partial => "collection/collection_view", :locals => {:images => @selected_collection, :images_per_row => 3, :link_description => "remove bookmark", :method => "remove_bookmark"}))%>').appendTo('#center_panel_content').hide().fadeIn('1000');

<%end%>

$(".scrap_block").hover(function() {
	$(this).children(".edit_icon").fadeIn();		
}, function() {
	$(this).children(".edit_icon").fadeOut();		
});