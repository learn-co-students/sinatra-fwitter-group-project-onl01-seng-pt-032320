class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    self.username.downcase.gsub(" ","-")
  end

  def find_by_slug(slug)
    self.all.find do |instance|
      if instance.slug == slug
      end
  end
end                                                                                                   

end
