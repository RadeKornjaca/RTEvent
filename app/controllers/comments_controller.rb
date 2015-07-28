class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
	skip_before_filter :verify_authenticity_token

  respond_to :html, :json

  def index
    @comments = Comment.all
    respond_with(@comments)
  end

	def event_comments
		ActiveRecord::Base.include_root_in_json = false
		id = params[:event_id]
		result = {'comments' => Comment.where(event_id: id).sort{|c1, c2| c2.created_at <=> c1.created_at}}.to_json
		send_data result
	end	

  def show
    respond_with(@comment)
  end

  def new
    @comment = Comment.new
    respond_with(@comment)
  end

  def edit
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.save
    respond_with(@comment)
  end

  def update
    @comment.update(comment_params)
    respond_with(@comment)
  end

  def destroy
    @comment.destroy
    respond_with(@comment)
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:user_id, :event_id, :content)
    end
end
