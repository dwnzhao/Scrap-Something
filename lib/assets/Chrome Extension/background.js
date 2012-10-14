chrome.browserAction.onClicked.addListener(function(tabs) {
	blanketScreen();
});

function blanketScreen() {	 
	chrome.tabs.executeScript(null, {file: "overlay.js"});
}