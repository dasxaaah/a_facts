class Article < ApplicationRecord
  mount_uploader :cover_image, ArticleCoverImageUploader
  serialize :subcategories, coder: JSON, type: Array

  CATEGORIES = %w[Разборы Технологии Личности Подборки].freeze
  SUBCATEGORIES_BY_CATEGORY = {
    "Разборы" => [
      "От идеи до финала",
      "Создание локаций",
      "Разрушения, взрывы",
      "Невидимые эффекты",
      "Существа и персонажи",
      "Сложные симуляции",
      "Транспорт и техника",
      "Клонирование, массовка"
    ],
    "Технологии" => [
      "Houdini",
      "Nuke локаций",
      "Unreal Engine",
      "Maya / 3ds Max / Blender"
    ],
    "Личности" => [
      "Интервью",
      "Истории успеха",
      "Студийные кейсы"
    ]
  }.freeze
  CATEGORY_LABELS = {
    "Разборы" => "Разборы сцен"
  }.freeze

  belongs_to :user
  validates :category, inclusion: { in: CATEGORIES }, allow_blank: true
  validates :subcategory, inclusion: { in: SUBCATEGORIES_BY_CATEGORY.values.flatten }, allow_blank: true
  validate :subcategories_are_known

  before_validation :normalize_subcategories

  def reading_minutes
    words = body.to_s.split.size
    [ (words / 180.0).ceil, 1 ].max
  end
  has_many :favourite_articles, dependent: :destroy
  has_many :favourited_by_users, through: :favourite_articles, source: :user

  private

  def normalize_subcategories
    self.subcategories = Array(subcategories).reject(&:blank?).uniq
    self.subcategories = [ subcategory ].compact_blank if subcategories.blank? && subcategory.present?
    self.subcategory = subcategories.first if subcategories.present?
  end

  def subcategories_are_known
    unknown_subcategories = subcategories - SUBCATEGORIES_BY_CATEGORY.values.flatten
    return if unknown_subcategories.empty?

    errors.add(:subcategories, "содержит неизвестные значения: #{unknown_subcategories.join(', ')}")
  end
end
