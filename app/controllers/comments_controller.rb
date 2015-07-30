class CommentsController < ApplicationController
  before_action :authenticate_user!
	skip_before_filter :verify_authenticity_token				#	FIXME: This needs to be removed. Secure vulnerability

  respond_to :json

  def index
		id = params[:event_id]
		@comments = {'comments' => Comment.for_event(id) }
		render json: @comments
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.save
    head :created
  end

  private

    def comment_params
      params.require(:comment).permit(:user_id, :event_id, :content)
    end
end
