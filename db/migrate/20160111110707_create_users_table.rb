class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, unique: true
      t.string :password_hash
      t.string :username, null: false, unique: true
      t.string :soundcloud_token
      t.string :avatar_link
      t.string :soundcloud_uri
    end
  end
end
