class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  validates :email, presence: true

  def slug
    username = self.username
    slug = username.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end

  def find_by_slug(slug)
    @slug = slug
    format_slug_beginning
    results = self.where("username LIKE ?", @short_slug)
    results.detect do |result|
      result.slug === @slug
    end
  end 

  def format_slug_beginning
    slug_beginning = @slug.split("-")[0]
    slug_beginning.prepend("%")
    slug_beginning << "%"
    @short_slug = slug_beginning
  end
end
