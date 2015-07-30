
(function() {
	var Comment = function ($resource) {
		return $resource('/events/:event_id/comments.json');
	}

	var app = angular.module('commentMaintainer');
	app.factory('Comment', Comment);
})()
