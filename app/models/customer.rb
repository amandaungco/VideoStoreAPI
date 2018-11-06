class Customer < ApplicationRecord

  has_many :rentals
  has_many :movies, through: :rentals

  before_create :set_movies_checked_out_count_default


  def check_out_movie
    if self.movies_checked_out_count == nil
      self.movies_checked_out_count = 1
      self.save
    else
      self.movies_checked_out_count += 1
      self.save
    end
  end

  def check_in_movie
    self.movies_checked_out_count -= 1
    self.save
  end


  private

  def set_movies_checked_out_count_default
    self.movies_checked_out_count = 0
  end

end
