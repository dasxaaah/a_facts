class RemoveCreatedAtFromArticles < ActiveRecord::Migration[8.1]
  def change
    remove_column :articles, :created_at, :datetime
  end
end