class Article < ApplicationRecord
  mount_uploader :cover_image, ArticleCoverImageUploader
  CATEGORIES = %w[Разборы Технологии Личности Подборки].freeze

  validates :category, inclusion: { in: CATEGORIES }, allow_blank: true
  def reading_minutes
    words = body.to_s.split.size
    [(words / 180.0).ceil, 1].max
  end
  has_many :favourite_articles, dependent: :destroy
  has_many :favourited_by_users, through: :favourite_articles, source: :user
end

