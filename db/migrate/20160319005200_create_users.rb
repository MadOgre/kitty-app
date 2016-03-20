class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :fullname
      t.string :username, null: false
      t.string :slug
      t.string :email, null: false

      t.timestamps null:false
    end
    add_index :users, :username, unique: true
    add_index :users, :slug, unique: true
    add_index :users, :email, unique: true
  end
end
