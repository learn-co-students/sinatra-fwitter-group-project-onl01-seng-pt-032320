class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  validates :email, presence: true

  def slug
    username = self.username
    slug = username.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end

end
