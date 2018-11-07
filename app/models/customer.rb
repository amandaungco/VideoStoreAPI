class Customer < ApplicationRecord

  has_many :rentals
  has_many :movies, through: :rentals

  def movies_checked_out_count
    return self.rentals.where(checkin_date: Date.new(0)).length
  end

end
