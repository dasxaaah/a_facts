class Post < ApplicationRecord
  belongs_to :user, optional: true
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  validates :body,  presence: true
  mount_uploader :post_image, PostImageUploader
  has_rich_text :body
end
