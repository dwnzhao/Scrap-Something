$(document).ready(function() {


$(function() {
	
	$(".tab_check_box").click(function() {
	
		$("#tab_update").fadeIn();
	});
	
	$("#create_tab_in_scrap_detail").click(function(){

		$("#tab_field").fadeIn();
		$("#tab_update").fadeIn();
		$("#create_tab_in_scrap_detail").fadeOut();
	});
});

new Morris.Line({
  // ID of the element in which to draw the chart.
  element: 'myfirstchart',
  // Chart data records -- each entry in this array corresponds to a point on
  // the chart.
  data: [
    { year: '2008', clicks: 20 },
    { year: '2009', clicks: 10 },
    { year: '2010', clicks: 5 },
    { year: '2011', clicks: 5 },
    { year: '2012', clicks: 20 }
  ],
  // The name of the data record attribute that contains x-values.
  xkey: 'year',
  // A list of names of data record attributes that contain y-values.
  ykeys: ['clicks'],
  // Labels for the ykeys -- will be displayed when you hover over the
  // chart.
  labels: ['clicks']
});
});