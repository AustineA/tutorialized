class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.string :f_name
      t.string :l_name
      t.string :link
      t.boolean :author, null: false, default: false

      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :username, unique: true
  end
end
