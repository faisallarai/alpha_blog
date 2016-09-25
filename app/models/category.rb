class Category < ApplicationRecord
  belongs_to :user
  has_many :article_categories
  has_many :articles, through: :article_categories
  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :description, length: { maximum: 1000 }
  validates_uniqueness_of :name
  validates :user_id, presence: true
end