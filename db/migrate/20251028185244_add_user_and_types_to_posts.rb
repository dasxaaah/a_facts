class AddUserAndTypesToPosts < ActiveRecord::Migration[7.1]
  def change
    add_reference :posts, :user, foreign_key: true, null: true

    add_column :posts, :post_type, :integer, default: 1, null: false  # 1 = question
  end
end