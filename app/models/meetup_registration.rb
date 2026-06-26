class MeetupRegistration < ApplicationRecord
  belongs_to :user

  validates :meetup_slug, :meetup_title, :meetup_url, presence: true
  validates :meetup_slug, uniqueness: { scope: :user_id }
end
