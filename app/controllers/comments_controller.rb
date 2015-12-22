class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ticket, only: [ :create ]

  def create
    @comment = @ticket.comments.create comment_params
    @comment.user_id = current_user.id
    @comment.save
    redirect_to @ticket
  end

  private

    def set_ticket
      @ticket = TicketsResources.get_ticket(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:message)
    end
end
