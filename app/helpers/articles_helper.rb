module ApplicationHelper
  CATEGORY_ICONS = {
    "Разборы" => "icons/analysis.svg",
    "Технологии" => "icons/tech.svg",
    "Личности" => "icons/person.svg",
    "Подборки" => "icons/collection.svg"
  }.freeze

  def category_icon(category)
    CATEGORY_ICONS[category]
  end
end