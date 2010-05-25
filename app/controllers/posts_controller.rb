class PostsController < ApplicationController
  before_filter :admin_required, :only => [:new, :create, :edit, :update]
  def index
    @posts = Post.paginate(:page => params[:page], :per_page => 5, :include =>  [:category, :tags])
  end
  
  def search
    @search = Search.new(params[:search])
    @query = []
    if params[:search]
      params[:search].reject{|k,v| v=='' || k=="category_id"}.each do |k,v|
        if k == 'tags'
          v.split(', ').each{|a| @query << a}
        else
          @query << v
        end
      end
      @query.join(", ")
      @posts = @search.posts.paginate(:page => params[:page], :per_page => 5, :include =>  [:category, :tags])
    end
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(params[:post])
    if @post.save
      redirect_to @post
    else
      flash[:error] = "Не удалось создать пост"
      render :action => 'new'
    end
  end
  
  def show
    @post = Post.find(params[:id])
  end
  
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      redirect_to @post
    else
      flash[:error] = "Не удалось редактировать пост"      
      render :action => "new"
    end
  end
end
