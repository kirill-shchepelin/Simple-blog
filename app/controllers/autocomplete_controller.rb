class AutocompleteController < ApplicationController
  
  
  def category
    @categories = Category.find(:all, :conditions => ["name like ?", "%#{params[:q]}%"])
		@results =[]
    @categories.each do |a|
      @results << [["#{a.name}"], ["#{a.id}"]]
    end
		respond_to do |format|
		  format.js
    end
	end
	
	def tags
	  @tags = Tag.find(:all, :conditions => ["name like ?", "%#{params[:q]}%"]).collect(&:name)	  
		respond_to do |format|
		  format.js
    end	  
  end
 
end
