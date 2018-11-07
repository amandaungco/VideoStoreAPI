require "test_helper"
#Validate only those fields that, if they are absent, will break your API.

describe Customer do
  let(:amanda) { customers(:Amanda)}

  it "must be valid" do
    value(amanda).must_be :valid?
  end

  describe "relations" do
    it "has many customers" do
      amanda.must_respond_to :movies
      amanda.movies.each do |movie|
        movie.must_be_kind_of Movie
      end
    end

    it "has many rentals" do
      amanda.must_respond_to :rentals
      amanda.rentals.each do |rental|
        rental.must_be_kind_of Rental
      end
    end

    it "can have no rentals" do
      amanda.rentals.destroy_all
      amanda.must_respond_to :rentals
      expect(amanda.rentals).must_equal []
    end

    it "can have no movies" do
      amanda.rentals.destroy_all

      amanda.must_respond_to :movies
      expect(amanda.movies).must_equal []
    end


  end

  describe 'custom methods' do
  

  end
end
