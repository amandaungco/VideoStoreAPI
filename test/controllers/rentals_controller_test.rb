require "test_helper"

describe RentalsController do
  let(:harry){movies(:movie1)}
  let(:dani){customers(:Dani)}
  let(:mock_hash){
    {
      customer_id: dani.id,
      movie_id: harry.id

    }
  }

  describe "check_out" do
    it 'can create a new instance of rental given valid data' do
      starting_inventory = harry.available_inventory
      expect {
        post check_out_path(mock_hash)
      }.must_change 'Rental.count', 1

      harry.reload
      expect(harry.available_inventory).must_equal starting_inventory - 1
      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include "id"
      rental = Rental.find(body["id"].to_i)
      expect(rental.movie_id).must_equal mock_hash[:movie_id]

      must_respond_with :success
    end

    it "returns an error for invalid rental data" do
      # arrange
      mock_hash[:customer_id] = nil

      expect {
        post check_out_path(mock_hash)
      }.wont_change "Rental.count"

      body = JSON.parse(response.body)

      expect(body).must_be_kind_of Hash

      expect(body).must_include "errors"
      #expect(body["errors"]).must_include :customer_id
      must_respond_with :bad_request
    end

    it 'wont create a new instance of rental if theres not enough inventory' do
      movie = movies(:movie4)
      mock_hash[:movie_id]= movie.id
      post check_out_path(mock_hash)
      body = JSON.parse(response.body)

      expect(body).must_be_kind_of Hash

      expect(body).must_include "errors"
      must_respond_with :bad_request
    end
  end

  describe "check_in" do
    it 'can update an instance of rental' do
      post check_out_path(mock_hash)
      expect{
        post check_in_path(mock_hash)
      }.wont_change 'Rental.count'

      expect(Rental.all.last.checkin_date).must_equal Date.today
      must_respond_with :success
    end

    it 'wont update an new instance of rental if its already been checkedin' do
      post check_in_path(mock_hash)
      post check_in_path(mock_hash) #try checking in again
      must_respond_with :bad_request
    end

    # it "returns an error for checking in an invalid rental" do
    #   mock_hash[:customer_id] = nil
    #
    #   expect {
    #     post check_out_path(mock_hash)
    #   }.wont_change "Rental.count"
    #
    #   body = JSON.parse(response.body)
    #
    #   expect(body).must_be_kind_of Hash
    #
    #   expect(body).must_include "errors"
    #   #expect(body["errors"]).must_include :customer_id
    #   must_respond_with :bad_request
    # end
  end
end
