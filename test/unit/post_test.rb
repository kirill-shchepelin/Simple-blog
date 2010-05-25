require 'test_helper'

class PostTest < ActiveSupport::TestCase

  
  def new_post(attributes= {})
    attributes[:title] ||= 'foo'
    attributes[:body] ||= 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In id venenatis elit. Nulla vitae risus ac odio vulputate sagittis. Ut a nisl tellus. Donec sit amet nulla et urna rutrum tristique nec vel tortor. In hac habitasse platea dictumst. Duis fringilla egestas mi in pulvinar. Suspendisse potenti. Ut eu lectus eu felis scelerisque fermentum. Maecenas ac ipsum et lorem feugiat cursus. Fusce porta, massa et fermentum pharetra, arcu tellus tincidunt dui, in ultrices orci tellus at enim. Fusce adipiscing ultricies libero mollis blandit. Proin quis nulla metus, at blandit est. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris a tortor in eros iaculis ullamcorper non id risus. Ut dolor justo, tincidunt vel convallis et, consequat sit amet urna. Aliquam ut magna eros, a varius ante. '
    post = Post.new(attributes)
    post.valid?
    post
  end
    
  def setup
    Post.delete_all
    Category.delete_all
  end   
  
  def test_valid   
    assert new_post.valid?
  end
  
  def test_require_title
    assert new_post(:title => '').errors.on(:title)
  end
  
  def test_require_body
    assert new_post(:body => '').errors.on(:body)
  end
  
  def test_no_category
    post = new_post
    post.save!
    assert_equal post.category_name, ''
  end
  
  def test_category
    category = Category.create(:name => "First Category")
    post = new_post
    post.category = category
    post.save!
    assert_equal post.category_name, 'First Category'
  end
  
end
