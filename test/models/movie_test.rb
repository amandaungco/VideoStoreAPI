require "test_helper"
#Validate only those fields that, if they are absent, will break your API.
describe Movie do
  let(:harry) { movies(:movie2)}
  let(:norents_movie) { movies(:movie3)}

  it "must be valid" do
    expect(harry).must_be :valid?
  end

  describe "relations" do
    it "has many customers" do
      harry.must_respond_to :customers

      harry.customers.each do |customer|
        customer.must_be_kind_of Customer
      end
      expect(harry.customers.count).must_equal 2
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
      norents_movie.must_respond_to :customers
      expect(norents_movie.customers).must_equal []
    end


  end

  describe "Validations" do
    let(:mock_hash) {
      {
          title: "Harry Potter & the Sorcerer Stone2",
          release_date: "1990-10-23",
          overview: "The most enchanting athletic event in history",
          inventory: 4
      }
    }
    it 'will save movie with valid params' do
      movie = Movie.new(mock_hash)
      movie.save

      valid = movie.valid?

      expect(valid).must_equal true

    end

    it 'must have title' do
      harry.title = nil
      harry.save

      valid = harry.valid?

      expect(valid).must_equal false
      expect(harry.errors.messages[:title]).must_equal ["can't be blank"]
    end

    it 'must have unique title' do

      norents_movie.title = harry.title
      norents_movie.save

      valid = norents_movie.valid?

      expect(valid).must_equal false
      expect(norents_movie.errors.messages[:title]).must_equal ["has already been taken"]
    end

    it 'must have overview' do
      harry.overview = nil
      harry.save

      valid = harry.valid?

      expect(valid).must_equal false
      expect(harry.errors.messages[:overview]).must_equal ["can't be blank"]
    end

    it 'must have release_date' do
      harry.release_date = nil
      harry.save

      valid = harry.valid?

      expect(valid).must_equal false
      expect(harry.errors.messages[:release_date]).must_equal ["can't be blank"]
    end

    it 'must have valid inventory' do
      invalid_inv = [nil, 1.0, 0, "string"]

      invalid_inv.each do |value|
        harry.inventory = value
        harry.save

        valid = harry.valid?
        expect(valid).must_equal false
        valid_errors = [["is not a number"],["must be an integer"],["must be greater than 0"]]
        expect(valid_errors).must_include harry.errors.messages[:inventory]
      end
    end

  end
end
