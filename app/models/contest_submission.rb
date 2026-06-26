class ContestSubmission < ApplicationRecord
  mount_uploader :image, PostImageUploader

  belongs_to :user

  validates :contest_slug, :image, presence: true
end
