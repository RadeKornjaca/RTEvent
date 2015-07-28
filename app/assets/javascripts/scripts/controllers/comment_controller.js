(function() {
	var CommentController = function($scope, Comment) {
		
		$scope.init = function(eventId) {
			$scope.eventId = eventId
			refreshStream()
		}
		
		$scope.comment = function(userId, eventId) {
			console.log($scope.commentText)
			var comment = {
				user_id : userId,
				event_id : eventId,
				content : $scope.commentText
			}
			
			var newComment = new Comment(comment)
			
			newComment.$save()
			
			$scope.commentText = ""
			refreshStream()
		}
		
		
		var refreshStream = function() {
			Comment.get({event_id : $scope.eventId}, function(response){
				$scope.comments = response.comments
				$scope.numberOfComments = response.comments.length
			})		
		}
		
		
	}
	
	
	var app = angular.module('commentMaintainer')
	app.controller('CommentController', CommentController)
})();
