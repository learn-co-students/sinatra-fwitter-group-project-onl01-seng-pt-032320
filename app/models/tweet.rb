class Tweet < ActiveRecord::Base
  belongs_to :user

  def slug
    @name=self.content.downcase.gsub(" ","-")
  end
  
end
