require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead.
  # Then, you can remove it from this and the functional test.
  include AuthenticatedTestHelper
  fixtures :employees
  
  should "create employee" do
    assert_difference 'Employee.count' do
      employee = create_employee
      assert !employee.new_record?, "#{employee.errors.full_messages.to_sentence}"
    end
  end
  
  
  

protected
  def create_employee(options = {})
    record = Employee.new({ :login => 'quire', :email => 'quire@example.com', :password => 'quire69', :password_confirmation => 'quire69' }.merge(options))
    record.save
    record
  end
end
