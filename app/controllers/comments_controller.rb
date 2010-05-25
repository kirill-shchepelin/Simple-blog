class CommentsController < ApplicationController
  before_filter :admin_required, :only => [:reject, :approve, :destroy] 
  
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params[:comment])
    if logged_in?
      @comment.user_id = current_user.id
    end
    if @comment.valid?
      @comment.save
      respond_to do |format|
        format.js do
          render :update do |page|
            page.insert_html :bottom, "comments", :partial => "/posts/comment", :locals => {:comment => @comment}
            page.replace_html "new_comment", :partial => "/posts/new_comment"
          end
        end
      end
    else
      flash[:error] = "Не удалось создать комментарий"
    end
  end
  
  def reject
    @comment = Comment.find(params[:id])
    @comment.update_attribute(:status, "rejected")
    respond_to do |format|
      format.js do
        render :update do |page|
          page.replace "comment_#{@comment.id}", :partial => "/posts/comment"
        end
      end
    end
  end
  
  def approve
    @comment = Comment.find(params[:id])
    @comment.update_attribute(:status, "approved")
    respond_to do |format|
      format.js do
        render :update do |page|
          page.replace "comment_#{@comment.id}", :partial => "/posts/comment"
        end
      end
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    respond_to do |format|
      format.js do
        render :update do |page|
          page.replace "comment_#{@comment.id}", ""
        end
      end
    end
  end
  
end
