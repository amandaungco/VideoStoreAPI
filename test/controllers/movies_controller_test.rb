require "test_helper"
#

describe MoviesController do
  let(:harry) { movies(:movie1)}
  describe "Index" do
    it "Will list all movies" do
      get movies_path
      must_respond_with :success
    end

    it "returns an Array" do
      # Act
      get movies_path

      # Convert the JSON response into a Hash
      body = JSON.parse(response.body)

      # Assert
      expect(body).must_be_kind_of Array
    end

    it "returns all of the movies" do
      # Act
      get movies_path

      # Convert the JSON response into a Hash
      body = JSON.parse(response.body)

      # Assert
      expect(body.length).must_equal Movie.count
    end
  end

  describe "show" do
    it "will return one movie" do
      get movie_path(harry.id)
      must_respond_with :success
      #maybe add checks for specific returned values
    end
  end

  describe "Create" do
    # let(:mock_hash) { movie:
    #    {
    #   title: "Harry Potter and the GOF",
    #   release_date: "1990-10-23",
    #   overview: "The most enchanting athletic event in history",
    #   inventory: 4
    #  }
    # }
    #
    # it "will create a new movie with valid data" do
    #   post movies_path(mock_hash)
    #   must_respond_with :success
    # end
  end





# it "returns pets with exactly the required fields" do
#   keys = %w(age human id name)
#
#   # Act
#   get pets_path
#
#   # Convert the JSON response into a Hash
#   body = JSON.parse(response.body)
#
#   # Assert that each
#   body.each do |pet|
#     expect(pet.keys.sort).must_equal keys
#     expect(pet.keys.length).must_equal keys.length
#   end
# end


end
