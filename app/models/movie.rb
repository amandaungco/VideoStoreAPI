class Movie < ApplicationRecord
  has_many :rentals
  has_many :customers, through: :rentals

  validates :title, presence: true , uniqueness: true
  validates :overview, presence: true
  validates :release_date, presence: true
  validates :inventory, numericality: { only_integer: true, greater_than: 0 }
end
