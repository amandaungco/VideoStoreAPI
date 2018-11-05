require "test_helper"

describe Rental do
  let(:rental) { rentals(:rent1)}

  it "must be valid" do
    value(rental).must_be :valid?
  end
  #can't be nil for customer_id or movie_id

  describe "relations" do
    it "has a customer" do
      rental.must_respond_to :customer
      expect(rental.customer).must_be_kind_of Customer
      expect(rental.customer.name).must_equal "Amanda"
    end

    it "has one movie" do
      rental.must_respond_to :movie
      expect(rental.movie).must_be_kind_of Movie
    end

    it "movie cannot be nil" do
      rental.movie = nil
      expect(rental.valid?).must_equal false
    end

    it "customer cannot be nil" do
      rental.customer = nil
      expect(rental.valid?).must_equal false
    end


  end
end
