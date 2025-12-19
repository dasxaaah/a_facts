class Admin::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post
  before_action :set_comment, only: :destroy
  before_action :authorize_comment!, only: :destroy

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to admin_post_path(@post), notice: "Комментарий добавлен"
    else
      redirect_to admin_post_path(@post), alert: "Ошибка, проверьте комментарий"
    end
  end

  def destroy
    @comment.destroy
    redirect_to admin_post_path(@post), notice: "Комментарий удалён"
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def authorize_comment!
    return if current_user&.admin?
    return if @comment.user == current_user

    redirect_to admin_post_path(@post), alert: "Нет доступа"
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end