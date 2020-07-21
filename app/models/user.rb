class User < ActiveRecord::Base
  before_create :create_slug
  has_secure_password
  has_many :tweets

  private
  def create_slug
    self.slug = username.parameterize
  end
end
