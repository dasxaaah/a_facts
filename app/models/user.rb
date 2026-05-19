class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :posts, dependent: :nullify
  has_many :comments, dependent: :destroy
  has_many :favourite_posts
  has_many :favourites, through: :favourite_posts, source: :post
  has_many :favourite_articles, dependent: :destroy
  has_many :favourited_articles, through: :favourite_articles, source: :article
  has_many :favourite_lessons, dependent: :destroy
  has_many :favourited_lessons, through: :favourite_lessons, source: :lesson
  has_many :projects, dependent: :destroy
  has_many :likes, dependent: :destroy
end
