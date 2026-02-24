class Article < ApplicationRecord
  mount_uploader :cover_image, ArticleCoverImageUploader
  CATEGORIES = %w[Разборы Технологии Личности Подборки].freeze

  validates :category, inclusion: { in: CATEGORIES }, allow_blank: true
  def reading_minutes
    words = body.to_s.split.size
    [(words / 180.0).ceil, 1].max
  end
end

