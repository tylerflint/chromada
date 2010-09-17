$:.unshift(File.dirname(__FILE__)) 

require 'test_helper'
require 'mother'

class MotherTest < ActiveSupport::TestCase
  
  should "allow when have permission" do
    assert false
  end
  
  should "deny when don't have permission" do
    assert false
  end
  
end