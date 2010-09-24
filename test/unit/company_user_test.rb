require 'test_helper'

class CompanyUserTest < ActiveSupport::TestCase
  should "be valid" do
    assert CompanyUser.new.valid?
  end
end
