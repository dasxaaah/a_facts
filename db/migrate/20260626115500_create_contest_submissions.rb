class CreateContestSubmissions < ActiveRecord::Migration[8.0]
  def change
    create_table :contest_submissions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :contest_slug, null: false
      t.string :image, null: false

      t.timestamps
    end

    add_index :contest_submissions, :contest_slug
  end
end
