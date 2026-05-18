class CreateFavouriteArticles < ActiveRecord::Migration[8.1]
  def change
    create_table :favourite_articles do |t|
      t.integer :user_id
      t.integer :article_id

      t.timestamps
    end
  end
end
