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

    it "returns movies with exactly the required fields" do
      keys = %w(id release_date title)

      # Act
      get movies_path

      # Convert the JSON response into a Hash
      body = JSON.parse(response.body)

      # Assert that each
      body.each do |movie|
        expect(movie.keys.sort).must_equal keys
        expect(movie.keys.length).must_equal keys.length
      end
    end

    it 'will sort with valid parameter' do
      valid_sort = %w(title release_date)

      valid_sort.each do |sortby|
        get movies_path, params: { sort: sortby }
        body = JSON.parse(response.body)
        new_list = Movie.all.sort_by{ |movie| movie[sortby] }
        expect(body[0]["id"]).must_equal new_list[0].id
        expect(body[-1]["id"]).must_equal new_list[-1].id
        must_respond_with :success
      end

    end

    it 'will not sort for invalid parameter' do
      invalid_sort = %w(city dog nil)

      invalid_sort.each do |sortby|
        get movies_path, params: { sort: sortby }
        body = JSON.parse(response.body)
        expect(body).must_include "errors"
        must_respond_with :bad_request
      end
    end
  end

  describe "show" do
    it "will return one movie" do
      get movie_path(harry.id)
      must_respond_with :success
      #maybe add checks for specific returned values
    end

    it "returns movies with exactly the required fields" do
      keys = %w(available_inventory id inventory overview release_date title)

      # Act
      get movie_path(harry.id)

      # Convert the JSON response into a Hash
      movie = JSON.parse(response.body)

      # Assert that each

      expect(movie.keys.sort).must_equal keys
      expect(movie.keys.length).must_equal keys.length

    end

    it "will return status not_found for invalid movie" do

      get movie_path(-1)
      must_respond_with :not_found
      #maybe add checks for specific returned values
    end

  end

  describe "Create" do
    let(:mock_hash) {
       {
      title: "Harry Potter and the GOF",
      release_date: "1990-10-23",
      overview: "The most enchanting athletic event in history",
      inventory: 4
     }
    }

    it "will create a new movie with valid data" do
      post movies_path(mock_hash)
      must_respond_with :success
    end

    it "will not create a new movie with invalid params" do
      mock_hash[:title] = nil
      post movies_path(mock_hash)
      must_respond_with :bad_request
    end
  end








end
