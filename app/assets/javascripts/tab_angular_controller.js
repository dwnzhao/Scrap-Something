"use strict";

/* Controllers */

var module = angular.module('MyApp', ['ui']).
directive('clickTab', function(){
	return function(scope, elm, attrs) {
		elm.bind('click', function(){
			angular.element('li').removeClass('active');
			elm.addClass('active');			
		});
		elm.bind('hover', function(){
			elm.children().css('display', "block");
		});
		elm.bind('mouseleave', function() {
			angular.element('.delete').css('display', "none");
		});
	};
}).directive('addTabButton', function(){
	return function(scope, elm, attrs) {
		elm.bind('click', function(){
			angular.element('#add-button').css('display', "none");
			angular.element('#tab_form').removeClass('hide');
		});
	};
});


module.config(["$httpProvider", function(provider) {
	provider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
	provider.defaults.headers.put['Content-Type'] = 'application/json';
	}]
);



function TabController($scope, $http) {
	$http.get('/tab/get_tabs/').success(function(data) {
		$scope.tabs = data;
	});	

	$scope.addTab = function() {
		angular.element('#tab_form').addClass('hide');
		$http.post('/tab/create_tab/', {name: $scope.tabText}).success(function(data, status, headers, config) {
			$scope.tabText = '';
			angular.element('#add-button').css('display', "block");
			angular.element('body').append(data);
			$scope.tabs.push({name:$scope.tabText});
			
		}).error(function(data, status, headers, config) {

		});
	};

	$scope.addTabRefresh = function() {
		$scope.tabs.push({name:$scope.tabText});
		angular.element('#tab_form').addClass('hide');

		$http.put('/scrap/create_tab/', {name: $scope.tabText, url: document.URL}).success(function(data) {
			$scope.tabText = '';
			$scope.result = data;
			angular.element('#add-button').css('display', "block");

			angular.element('#tabs').html($scope.result);
		}).error(function(data, status, headers, config) {
			window.location = "/collection/tab_max_error"
		});
	};

	$scope.currentTab = {name: "home", id: ""};

	$scope.tabChange = function(tab) {
		if (tab == '') {
			$scope.currentTab = {name: "home", id: ""};
		}
		else {
			$scope.currentTab = tab;
		};

	};

}
