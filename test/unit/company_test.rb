require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  should "be valid" do
    assert Company.new.valid?
  end
end
