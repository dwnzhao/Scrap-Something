'use strict';

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
	$http.get('http://localhost:3000/tab/get_tabs/').success(function(data) {
		$scope.categories = data;
	});	

	$scope.add_category_form_visible = function() {
		angular.element('#category_form').removeClass('hide');
	};

	$scope.addCategory = function() {
		$scope.categories.push({name:$scope.tabText});
		angular.element('#category_form').addClass('hide');
		$http.put('http://localhost:3000/tab/create_tab/', {name: $scope.tabText}).success(function(data) {
			$scope.tabText = '';			
		});	
			
	};
	
};
