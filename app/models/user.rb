class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets
  validates_presence_of :username, :password, :email

  def slug
    self.username.parameterize
  end

  def self.find_by_slug(slug)
    self.find{|user| user.slug == slug}
  end
end
