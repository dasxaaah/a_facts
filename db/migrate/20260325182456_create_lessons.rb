class CreateLessons < ActiveRecord::Migration[8.1]
  def change
    create_table :lessons do |t|
      t.string :title
      t.string :module_name
      t.integer :lesson_number
      t.text :body

      t.timestamps
    end
  end
end
