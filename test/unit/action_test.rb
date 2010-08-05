require 'test_helper'

class ActionTest < ActiveSupport::TestCase
  should "be valid" do
    assert Action.new.valid?
  end
end
