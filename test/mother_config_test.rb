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
  
  should "return a flattened array of yaml tree" do
    assert_kind_of Array, Mother.get_flat_actions
  end
  
  should "separate tree levels with a /" do
    flattened = Mother.get_flat_actions(get_valid_config)
    assert_equal "employee/create", flattened[0]
  end
  
  should "not have a leading / on any actions" do
    flattened = Mother.get_flat_actions(get_valid_config)
    count = 0
    flattened.each do |flat|
      count += 1 if flat.match /^\//
    end
    assert_equal 0, count
  end
  
  should "not have a trailing / on any of the actions" do
    flattened = Mother.get_flat_actions(get_valid_config)
    count = 0
    flattened.each do |flat|
      count += 1 if flat.match /\/$/
    end
    assert_equal 0, count
  end
  
  should "maintain an accurate count of flattened actions relative to tree" do
    flattened = Mother.get_flat_actions(get_valid_config)
    assert_equal 9, flattened.length
  end
  
  should "seed actions table from flattened tree" do
    Action.delete_all
    Mother.seed_actions( get_valid_config )
    assert_equal 9, Action.all.length
  end
  
  should "not remove actions when same" do
    Action.delete_all
    Mother.seed_actions( get_valid_config )
    original_action = Action.find_by_path('employee/create/delete')
    Mother.seed_actions( get_valid_config )
    action = Action.find_by_path('employee/create/delete')
    assert_equal original_action, action
  end
  
  should "remove actions not included in the tree" do
    Action.delete_all
    Mother.seed_actions( get_valid_config )
    Mother.seed_actions( get_partial_config )
    assert_raise ActiveRecord::RecordNotFound  do
      Action.find(:conditions => {:path => 'employee/edit/lastname'})
    end
  end
  
  private
  
  def get_valid_config
    %{
      - employee:
          - create
          - delete
          - view:
              - firstname
              - lastname
          - edit:
              - firstname
              - lastname

      - role:
          - create
          - delete
          - edit
    }
  end
  
  def get_partial_config
    %{
      - employee:
          - create
          - delete
          - view:
              - firstname
              - lastname
          - edit:
              - firstname

      - role:
          - create
          - delete
          - edit
    }
  end
  
end