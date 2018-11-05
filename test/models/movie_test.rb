require "test_helper"
#Validate only those fields that, if they are absent, will break your API.
describe Movie do
  let(:movie) { Movie.new }
  let(:harry) { movies(:movie2)}

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

  end
end
