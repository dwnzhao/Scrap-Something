$(document).ready(function() {

	document.getElementById("vendor?_radio_button_yes").onclick = function () {
		if (document.getElementById("vendor?_radio_button_yes").checked) {
			document.getElementById("hidden_form").style.display = "block";
		} else {
			document.getElementById("hidden_form").style.display = "none";
		}
	};
	
	document.getElementById("vendor?_radio_button_no").onclick = function () {
		if (document.getElementById("vendor?_radio_button_yes").checked) {
			document.getElementById("hidden_form").style.display = "block";
		} else {
			document.getElementById("hidden_form").style.display = "none";
		}
	};
	
	document.getElementById("hidden_form").style.display = "none";	
});
