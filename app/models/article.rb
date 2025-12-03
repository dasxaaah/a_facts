class Article < ApplicationRecord
  belongs_to :user, optional: true

  enum article_type: {
    article: 1,
    tutorial: 2
  }
end

