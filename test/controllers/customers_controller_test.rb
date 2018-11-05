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
  end
end
