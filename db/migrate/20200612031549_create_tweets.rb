class CreateTweets < ActiveRecord::Migration[6.0]
  def change
    create_table :tweets do |tweet|
      tweet.string :content
    end
  end
end
