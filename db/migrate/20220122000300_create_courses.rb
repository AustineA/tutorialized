class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses, id: :uuid do |t|
      t.string :title
      t.string :repo
      t.text :description
      t.bigint :price, :default => 0
      t.string :slug
      t.string :user_id
      t.string :cover
      t.string :intro
      t.string :poster
      t.bigint :lessons_count, :default => 0

      t.timestamps
    end
    add_index :courses, :slug
    add_index :courses, :user_id

  end
end
