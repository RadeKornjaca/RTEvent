class Comment < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  belongs_to :event, dependent: :destroy

	def self.for_event event_id
		data = Comment.where(event_id: event_id).includes(:user).order(created_at: :desc)
		filtered_data = data.select(:id, :content, :user_id).as_json(:include => {:user => {:only => [:username]}})			#	takes only what is needed, since it's used for creating a JSON response

		filtered_data
	end
end
