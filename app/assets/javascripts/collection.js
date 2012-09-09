window.onload = function() {

var searchBox = document.getElementById("search");
searchBox.value = "search for ideas";

searchBox.onfocus = function() {
	if ( searchBox.value == "search for ideas") {
		searchBox.value = "";
	}
};

searchBox.onblur = function () {
	if ( searchBox.value == "") {
		searchBox.value = "search for ideas";
	}
};

}