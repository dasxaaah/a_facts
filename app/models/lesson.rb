class Lesson < ApplicationRecord
  mount_uploader :cover_image, ArticleCoverImageUploader

  validates :title, presence: true
  validates :module_name, presence: true
  validates :lesson_number, presence: true
  validates :body, presence: true

  has_many :favourite_lessons, dependent: :destroy
  has_many :favourited_by_users, through: :favourite_lessons, source: :user
end
