class Book < ApplicationRecord
  has_many :reviews, dependent: :destroy
  # has_many :users, through: :reviews
  validates :title, presence: true, uniqueness: true
  validates :author, presence: true
  validates :published_year, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
