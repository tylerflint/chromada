require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  should have_many(:resources)
  should belong_to(:company)
  should have_and_belong_to_many(:employees)
  
  should "be valid" do
    assert Role.new.valid?
  end
end
