class Post < ActiveRecord::Base
  
  cattr_reader :per_page
  @@per_page = 5
  
  belongs_to :category
  belongs_to :user
  has_many :comments, :order => "updated_at ASC"
  acts_as_taggable
  validates_presence_of :title, :body
  
  def category_name
    if category
      category.name
    else
      ""
    end
  end
  
  
end
