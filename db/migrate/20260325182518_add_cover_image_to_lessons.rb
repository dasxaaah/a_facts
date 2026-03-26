class AddCoverImageToLessons < ActiveRecord::Migration[8.1]
  def change
    add_column :lessons, :cover_image, :string
  end
end
