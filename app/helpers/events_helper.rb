module EventsHelper
	def comments_number event
		comments = Comment.all
		comments.select{ |comment| comment.event_id == event.id }.count
	end

end
