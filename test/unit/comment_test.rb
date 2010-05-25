require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  def new_user(attributes = {})
    attributes[:username] ||= 'foo'
    attributes[:email] ||= 'foo@example.com'
    attributes[:password] ||= 'abc123'
    attributes[:password_confirmation] ||= attributes[:password]
    user = User.new(attributes)
    user.valid? # run validations
    user.save
    user
  end
  
  def new_post(attributes={})
    attributes[:title] ||= "title"
    attributes[:body] ||= "body"
    post = new_user.posts.new(attributes)
    post.valid?
    post.save
    post
  end

  
  def new_comment(attributes={})
    attributes[:body] ||= "comment body"
    attributes[:guest_name] ||= "Guest"
    new_post.comments.create!(attributes)
  end
  
  def new_comment_user(attributes={})
    attributes[:body] ||= "comment body"    
    user = new_user
    comment = new_post.comments.new(attributes)
    comment.user = user
    comment
  end
    
  def setup
    User.delete_all
    Post.delete_all
  end
  
  def test_valid   
    assert new_comment.valid?
  end

  def test_guest_name
    assert_equal new_comment.owner, "Guest (Гость)"
  end
  
  def test_user_name
    assert_equal new_comment_user.owner, 'foo'
  end
  

  
end
