class Comment < ActiveRecord::Base

  before_create :captcha_or_user_id
  belongs_to :post
  belongs_to :user
  apply_simple_captcha
    
  def captcha_or_user_id
    if user_id.nil?
      if !self.valid_with_captcha?
        errors.add(:captcha, "Неверная каптча")
        false
      end
    end
  end
  
  def owner
    if self.user_id.nil?
      guest_name.to_s + " (Гость)"
    else
      user.username
    end
  end
  
  
end
