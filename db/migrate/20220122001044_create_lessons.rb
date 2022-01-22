class CreateLessons < ActiveRecord::Migration[7.0]
  def change
    create_table :lessons, id: :uuid do |t|
      t.string :title
      t.text :description
      t.string :course_id
      t.string :user_id
      t.string :video
      t.string :cover

      t.timestamps
    end
    add_index :lessons, :course_id
    add_index :lessons, :user_id

  end
end
