class Customer < ApplicationRecord

  has_many :rentals
  has_many :movies, through: :rentals

  def check_out_movie
      self.movies_checked_out_count += 1
      self.save
  end

  def check_in_movie
    self.movies_checked_out_count -= 1
    self.save
  end

end
