class Lesson < ApplicationRecord
  mount_uploader :cover_image, ArticleCoverImageUploader

  validates :title, presence: true
  validates :module_name, presence: true
  validates :lesson_number, presence: true
  validates :body, presence: true
end