(function() {
	var CommentController = function($scope, Comment) {
		
		$scope.init = function(eventId) {
			refreshStream(eventId)
		}
		
		$scope.comment = function(userId, eventId) {
			var comment = {
				user_id : userId,
				event_id : eventId,
				content : $scope.commentText
			}
			
			var newComment = new Comment({comment: comment})
			
			newComment.$save({event_id : eventId})
			
			$scope.commentText = ""
			refreshStream(eventId)
		}
		
		
		var refreshStream = function(eventId) {
			Comment.get({event_id : eventId}, function(response){
				$scope.comments = response.comments
				$scope.numberOfComments = response.comments.length
			})		
		}
		
		
	}
	
	
	var app = angular.module('commentMaintainer')
	app.controller('CommentController', CommentController)
})();
