class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  validates_presence_of  :username, :email, :password_digest

  def slug
    
  end

  def find_by_slug

  end
end
