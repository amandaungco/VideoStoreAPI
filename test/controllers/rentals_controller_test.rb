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
    it 'can create a new instance of rental' do
      starting_inventory = harry.available_inventory
      expect {
        post check_out_path(mock_hash)
      }.must_change 'Rental.count', 1
      harry.reload
      expect(harry.available_inventory).must_equal starting_inventory - 1

      must_respond_with :success
    end

    it 'wont create a new instance of rental if theres not enough inventory' do
      harry.available_inventory = 0
      harry.save
      post check_out_path(mock_hash)
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
  end
end
