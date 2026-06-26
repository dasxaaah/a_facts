class AddSubcategoriesToArticles < ActiveRecord::Migration[8.0]
  def change
    add_column :articles, :subcategories, :text
  end
end
