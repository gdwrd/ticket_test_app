module CommentsHelper
  def comments_table
    render partial: 'comments_table'
  end

  def new_comment_form
    if !current_user.nil? && current_user.tickets.include?(@ticket)
      render partial: 'comment_form'
    end
  end
end