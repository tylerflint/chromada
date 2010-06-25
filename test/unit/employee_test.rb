require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase
  # include AuthenticatedTestHelper
  fixtures :employees
  
  should belong_to(:company)
  should have_and_belong_to_many(:roles)
  
  should validate_presence_of(:email)
  should ensure_length_of(:email).is_at_least(6).is_at_most(100)
  should validate_uniqueness_of(:email)
  
  
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
