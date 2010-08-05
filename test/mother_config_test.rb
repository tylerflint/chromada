$:.unshift(File.dirname(__FILE__)) 

require 'test_helper'
require 'mother'

class MotherConfigTest < ActiveSupport::TestCase
  
  should "throw an error if unable to load config" do
    assert_raise RuntimeError, Errno::ENOENT do
      Mother.load_config("", 'fake.yml')
    end
  end
  
  should "not throw an error if able to load config" do
    assert_nothing_thrown do
      Mother.load_config
    end
  end
  
  # should "throw an error if improper yaml format is present" do
  #   assert_raise RuntimeError do
  #     Mother.load_config( get_invalid_config )
  #   end
  # end
  
  should "return a flattened array of yaml tree" do
    assert_kind_of Array, Mother.get_flat_actions
  end
  
  should "separate tree levels with a /" do
    assert false
  end
  
  should "not have a leading / on any actions" do
    assert false
  end
  
  should "not have a trailing / on any of the actions" do
    assert false
  end
  
  should "maintain an accurate count of flattened actions relative to tree" do
    assert false
  end
  
  private
  
  def get_valid_config
    %{
      - employees:
          - create
          - delete
          - view:
              - firstname
              - lastname
          - edit:
              - firstname
              - lastname

      - roles:
          - create
          - delete
          - edit
    }
  end
  
end