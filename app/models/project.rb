class Project < ApplicationRecord
  STATUSES = %w[draft published].freeze
  KINDS = %w[photo video text].freeze

  belongs_to :user
  has_one_attached :media

  validates :title, presence: true
  validates :status, inclusion: { in: STATUSES }
  validates :kind, inclusion: { in: KINDS }

  scope :published, -> { where(status: "published") }
  scope :drafts, -> { where(status: "draft") }
end
