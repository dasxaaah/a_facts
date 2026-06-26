class Post < ApplicationRecord
  belongs_to :user, optional: true
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  validates :body,  presence: true
  mount_uploader :post_image, PostImageUploader
  has_rich_text :body

  def post_image_available?
    post_image.present? && post_image.file&.exists?
  end
end
