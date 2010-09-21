$:.unshift(File.dirname(__FILE__)) 

require 'test_helper'
require 'mother'

class MotherTest < ActiveSupport::TestCase
  
  should "raise exception when child is not set" do
    assert_raise RuntimeError do
      Mother.set_child(nil)
      Mother.may_i?('employees/delete')
    end
  end
  
  should "raise exception when company is not set" do
    assert_raise RuntimeError do
      Mother.set_company(nil)
      Mother.may_i?('employees/delete')
    end
  end
  
  should "raise exception when child does not have id" do
    assert_raise NoMethodError do
      Mother.set_company(Company.find(1))
      Mother.set_child(1)
      Mother.may_i?('employees/delete')
    end
  end
  
  should "raise exception when company does not have id" do
    assert_raise NoMethodError do
      Mother.set_company(1)
      Mother.set_child(User.find(3))
      Mother.may_i?('employees/delete')
    end
  end
  
  should "allow when have permission" do
    company = Company.find(1)
    steve = User.find(3)
    Mother.set_company(company)
    Mother.set_child(steve)
    assert Mother.may_i?('employees/delete')
  end
  
  should "deny when don't have permission" do
    company = Company.find(1)
    erl = User.find(4)
    Mother.set_company(company)
    Mother.set_child(erl)
    assert !Mother.may_i?('employees/delete')
  end
  
end