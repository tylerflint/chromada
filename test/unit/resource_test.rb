require 'test_helper'

class ResourceTest < ActiveSupport::TestCase
  should belong_to(:role)
  
  should "be valid" do
    assert Resource.new.valid?
  end
end
