# frozen_string_literal: true

class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  has_secure_password
  has_many :tweets

  def self.find_by_slug(slug)
    all.find { |i| i.slug == slug }
  end

  def slug
    username.downcase.gsub(' ', '-')
  end
end
