class CreateMeetupRegistrations < ActiveRecord::Migration[8.0]
  def change
    create_table :meetup_registrations do |t|
      t.references :user, null: false, foreign_key: true
      t.string :meetup_slug, null: false
      t.string :meetup_title, null: false
      t.datetime :meetup_starts_at
      t.string :meetup_url, null: false

      t.timestamps
    end

    add_index :meetup_registrations, [ :user_id, :meetup_slug ], unique: true
  end
end
