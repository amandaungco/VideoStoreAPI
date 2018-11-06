class Movie < ApplicationRecord
  has_many :rentals
  has_many :customers, through: :rentals

  validates :title, presence: true , uniqueness: true
  validates :overview, presence: true
  validates :release_date, presence: true
  validates :inventory, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  before_create :set_available_inventory_default


  def check_out_movie
    self.available_inventory -= 1
    self.save
  end

  def check_in_movie
    self.available_inventory += 1
    self.save
  end

  def available?
    return self.available_inventory > 0
  end

  private

  def set_available_inventory_default
    self.available_inventory = self.inventory
  end

end
