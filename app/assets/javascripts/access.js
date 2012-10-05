$(document).ready(function() {
	// vendor form show & hide
	document.getElementById("vendor_yes").onclick = function () {$("#hidden_form").slideDown();};
	
	document.getElementById("vendor_no").onclick = function () {$("#hidden_form").slideUp();};
	
	if (document.getElementById("vendor_no").checked) {
		$("#hidden_form").hide();
		}	
});
