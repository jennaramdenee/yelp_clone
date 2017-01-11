class Restaurant < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :reviewed_restaurants, through: :reviews, source: :restaurant
  validates :name, length: {minimum: 3}, uniqueness: true
end
