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
    it 'adds a count to a custome movies_checked_out_count when a movie is checked out' do
      starting_count = amanda.movies_checked_out_count
      amanda.check_out_movie
      amanda.reload
      expect(amanda.movies_checked_out_count).must_equal starting_count + 1
    end

    it 'removes a count from a customer movies_checked_out_count when a movie is checked in' do
      starting_count = amanda.movies_checked_out_count
      amanda.check_in_movie
      amanda.reload
      expect(amanda.movies_checked_out_count).must_equal starting_count - 1
    end

  end
end
