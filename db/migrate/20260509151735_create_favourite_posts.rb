class CreateFavouritePosts < ActiveRecord::Migration[8.1]
  def change
    create_table :favourite_posts do |t|
      t.integer :user_id
      t.integer :post_od

      t.timestamps
    end
  end
end
