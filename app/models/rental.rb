class Rental < ApplicationRecord
  belongs_to :movie
  belongs_to :customer

  before_create :set_default_to_checkin_date

  def title
    return self.movie.title
  end

  def name
    return self.customer.name
  end

  private

  def set_default_to_checkin_date
    self.checkin_date = Date.new(0)
  end
end
