class Category < ActiveRecord::Base
  before_destroy :fix_posts
  belongs_to :parent, :class_name => "Category", :foreign_key => "parent_id"
  has_many :children, :class_name => "Category", :foreign_key => "parent_id", :dependent => :destroy
  has_many :posts
  named_scope :root, :conditions => {:parent_id => nil}
  
  def all_to_parent
    arr =[self.name]
    current = self
      while !current.parent.nil?
        arr << parent.name
        current = current.parent 
      end
    arr.reverse.join(" > ")
  end 
  
  def level_size
    a=0
    if self.parent.nil?
      a
    else
      current = self
      while !current.parent.nil?
        a+=1
        current = current.parent 
      end
      a
    end
  end
  
  def fix_posts
    posts.each{|p| p.update_attribute(:category_id, nil)}
  end
  
end
