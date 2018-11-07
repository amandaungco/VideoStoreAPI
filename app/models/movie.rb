class Movie < ApplicationRecord
  has_many :rentals
  has_many :customers, through: :rentals

  validates :title, presence: true , uniqueness: true
  validates :overview, presence: true
  validates :release_date, presence: true
  validates :inventory, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def available_inventory
    return (self.inventory) - (self.rentals.where(checkin_date: Date.new(0)).length)
  end
  # #
  # # def check_out_movie
  # #   self.available_inventory -= 1
  # #   self.save
  # # end
  # #
  # # def check_in_movie
  # #   self.available_inventory += 1
  # #   self.save
  # #   if self.available_inventory > self.inventory
  # #     render
  # #   end
  #
  # end

  def available?
    return self.available_inventory > 0
  end

end
