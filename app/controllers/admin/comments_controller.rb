# class CommentsController < ApplicationController
#   before_action :authenticate_user!
#   before_action :set_post, only: %i[ create destroy ]
  
#   def create
#     @comment = @post.comments.create(params[:comment].permit(:body))
#     redirect_to post_path(@post)
#   end

#   def destroy
#     @comment = @post.comments.find(params[:id])
#     @comment.destroy
#     redirect_to post_path(@post)
#   end
  
#   private
  
#     def set_post
#       @post = Post.find(params[:post_id])
#     end
  
# end

class Admin::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[create destroy]
  before_action :set_comment, only: %i[destroy]
  before_action :authorize_comment!, only: %i[destroy]

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    @comment.save!
    redirect_to post_path(@post)
  end

  # def destroy
  #   @comment.destroy
  #   redirect_to post_path(@post)
  # end
  def destroy
   @comment = @post.comments.find(params[:id])
    return redirect_to post_path(@post), alert: "Нет доступа" unless @comment.user == current_user

   @comment.destroy
   redirect_to post_path(@post)
  end
  
  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def authorize_comment!
    return if @comment.user == current_user

    redirect_to post_path(@post), alert: "Нет доступа"
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end