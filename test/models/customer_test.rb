require "test_helper"
#Validate only those fields that, if they are absent, will break your API.

describe Customer do
  let(:amanda) { customers(:Amanda)}

  it "must be valid" do
    value(amanda).must_be :valid?
  end
end
