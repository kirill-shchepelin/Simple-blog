class Search
  
  attr_accessor :tags, :body, :title, :category_id
  
  def initialize(params={})
    if !params.nil?
      params.each do |key,value|
        self.instance_variable_set("@#{key}", value)
      end
    end
  end
  
  def posts
    @posts ||= find_posts
  end
  
  private
  
  def find_posts
    if @tags.blank?
      Post.find(:all, :conditions => conditions)
    else
      query = @tags.split(', ')
      Post.tagged_with(query).all(:conditions => conditions)
    end
  end
  
  def body_conditions
    ["posts.body LIKE ?", "%#{@body}%"] unless @body.blank?    
  end
  
  def title_conditions
    ["posts.title LIKE ?", "%#{@title}%"] unless @title.blank?        
  end
  
  def category_conditions
    ["posts.category_id = ?", @category_id] unless @category_id.blank?
  end

  def conditions
    [conditions_clauses.join(' AND '), *conditions_options]
  end

  def conditions_clauses
    conditions_parts.map { |condition| condition.first }
  end

  def conditions_options
    conditions_parts.map { |condition| condition[1..-1] }.flatten
  end

  def conditions_parts
    private_methods(false).grep(/_conditions$/).map { |m| send(m) }.compact
  end
    
end
