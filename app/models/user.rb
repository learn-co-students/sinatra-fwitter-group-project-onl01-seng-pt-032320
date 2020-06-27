class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  validates :email, presence: true

  def slug
    username = username.downcase.strip.gsub(' ', '-')
  end 
end
