class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, null: false, unique: true
      t.string :password_digest, null: false
      t.string :session_token, null: false
      t.timestamps null: false
    end

    add_index :users, :username, unique: true
    add_index :users, :session_token
  end
end
