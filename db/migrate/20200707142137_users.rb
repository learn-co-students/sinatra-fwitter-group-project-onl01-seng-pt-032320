class Users < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :slug
      t.string :email
      t.string :password_digest, null: false
    end
  end
end
