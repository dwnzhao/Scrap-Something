"use strict";

/* Controllers */

var module = angular.module('MyApp', ['ui']).
directive('clickTab', function(){
	return function(scope, elm, attrs) {
		elm.bind('click', function(){
			angular.element('li').removeClass('active');
			elm.addClass('active');			
		});
	};
});

module.config(["$httpProvider", function(provider) {
  provider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
  provider.defaults.headers.put['Content-Type'] = 'application/json';

}]);



function TabController($scope, $http) {
	$http.get('/tab/get_tabs/').success(function(data) {
		$scope.tabs = data;
	});	

	$scope.add_tab_form_visible = function(elm) {
		angular.element('#tab_form').removeClass('hide');
    };

	$scope.addTab = function() {
		$scope.tabs.push({name:$scope.tabText});
		angular.element('#tab_form').addClass('hide');
		$http.put('/tab/create_tab/', {name: $scope.tabText}).success(function(data) {
			$scope.tabText = '';
		});

	};

	$scope.currentTab = {name: "home", id: ""};

	$scope.tabChange = function(tab) {
        if (tab == '') {
            $scope.currentTab = {name: "home", id: ""};
        }
        else {
            $scope.currentTab = tab;
        }

	};


};