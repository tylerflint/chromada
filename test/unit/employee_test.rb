require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase
  should "be valid" do
    assert Employee.new.valid?
  end
end
