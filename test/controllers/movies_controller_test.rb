require "test_helper"
#

describe MoviesController do
  let(:harry) { movies(:movie1)}
  describe "Index" do
    it "Will list all movies" do
      get movies_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "will return one movie" do
      get movie_path(harry.id)
      must_respond_with :success
    end
  end


end
