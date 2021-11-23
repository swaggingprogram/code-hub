class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to code_path(@comment.code)
    else
      @code = @comment.code
      @comments = @code.comments
      render "codes/show"
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:concept).merge(user_id: current_user.id, code_id: params[:code_id])
  end

end
