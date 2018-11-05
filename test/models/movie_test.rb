require "test_helper"
#Validate only those fields that, if they are absent, will break your API.
describe Movie do
  let(:movie) { Movie.new }
  let(:harry) { movies(:movie2)}
  let(:norents_movie) { movies(:movie3)}

  it "must be valid" do
    expect(movie).must_be :valid?
  end

  describe "relations" do
    it "has many customers" do
      harry.must_respond_to :customers
      harry.customers.each do |customer|
        customer.must_be_kind_of Customer
      end
    end

    it "has many rentals" do
      harry.must_respond_to :rentals
      harry.rentals.each do |rental|
        rental.must_be_kind_of Rental
      end
    end

    it "can have no rentals" do
      norents_movie.must_respond_to :rentals
      expect(norents_movie.rentals).must_equal []
    end

    it "can have no customers" do
    end


  end
end
