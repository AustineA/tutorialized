class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders, id: :uuid do |t|
      t.string :ref_no
      t.bigint :price, :default => 0
      t.bigint :download_count, :default => 0
      t.boolean :status, null: false, default: false   
      t.string :user_id
      t.string :course_id
      t.string :title
      t.string :country
      t.string :payment_method

      t.timestamps
    end

    add_index :orders, :user_id
    add_index :orders, :course_id
    add_index :orders, :ref_no
  end
end
