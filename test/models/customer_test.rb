require "test_helper"

describe Customer do
  let(:amanda) { customers(:Amanda)}

  it "must be valid" do
    value(amanda).must_be :valid?
  end
end
