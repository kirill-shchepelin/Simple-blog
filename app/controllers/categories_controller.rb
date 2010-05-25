class CategoriesController < ApplicationController
  before_filter :admin_required 
  
  
  def index
    @categories ||= Category.root.all
  end
  
  def new
    @category = Category.new
    render :update do |page|
      if params[:parent]
        page.replace "parent-#{params[:parent]}", :partial => "new_category", :locals => {:parent => params[:parent]}
      else
        page.replace "root", :partial => "new_category", :locals => {:parent => " "}
      end
    end
  end
  
  def create
    @category = Category.new(params[:category])
    @category.save
    render :update do |page|
      if @category.parent_id.nil?
        page.replace "new_category", :partial => "category", :locals => {:category => @category}
        page.insert_html :bottom, "categories", :partial => "new_root"
      else
        page.replace "new_category", :partial => "category", :locals => {:category => @category}
        page.insert_html :bottom, "list-#{@category.parent_id}", :partial => "new_not_root", :locals => {:parent => @category.parent_id}
      end
    end
  end
  
  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    render :update do |page|
      page.replace "category-#{params[:id]}", ""
    end
  end
  
  
end
