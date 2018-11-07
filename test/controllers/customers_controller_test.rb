require "test_helper"
# id
# name
# registered_at
# postal_code
# phone
# movies_checked_out_count
describe CustomersController do
  describe "Index" do
    it "Will list all customers" do
      get customers_path
      must_respond_with :success
    end

    it "returns an Array" do
      # Act
      get customers_path

      # Convert the JSON response into a Hash
      body = JSON.parse(response.body)

      # Assert
      expect(body).must_be_kind_of Array
    end

    it "returns all of the customers" do
      # Act
      get customers_path

      # Convert the JSON response into a Hash
      body = JSON.parse(response.body)

      # Assert
      expect(body.length).must_equal Customer.count
    end

    it "returns movies with exactly the required fields" do
      keys = %w(id movies_checked_out_count name phone postal_code registered_at)

      # Act
      get customers_path

      # Convert the JSON response into a Hash
      body = JSON.parse(response.body)

      # Assert that each
      body.each do |customer|
        expect(customer.keys.sort).must_equal keys
        expect(customer.keys.length).must_equal keys.length
      end
    end

    it 'will sort with valid parameter' do
      valid_sort = %w(name registered_at postal_code)

      valid_sort.each do |sortby|
        get customers_path, params: { sort: sortby }
        body = JSON.parse(response.body)
        new_list = Customer.all.sort_by{ |customer| customer[sortby] }
        expect(body[0]["id"]).must_equal new_list[0].id
        expect(body[-1]["id"]).must_equal new_list[-1].id
        must_respond_with :success
      end

    end

    it 'will not sort for invalid parameter' do
      invalid_sort = %w(city dog nil)

      invalid_sort.each do |sortby|
        get customers_path, params: { sort: sortby }
        body = JSON.parse(response.body)
        expect(body).must_include "errors"
        must_respond_with :bad_request
      end
    end
  end
end
