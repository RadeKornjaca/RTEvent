
(function() {
	var Comment = function ($resource) {
		return $resource('/comments/:event_id.json');
	}

	var app = angular.module('commentMaintainer');
	app.factory('Comment', Comment);
})()
