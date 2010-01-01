require File.dirname(__FILE__) + '/../test_helper'
require 'employees_controller'

# Re-raise errors caught by the controller.
class EmployeesController; def rescue_action(e) raise e end; end

class EmployeesControllerTest < ActionController::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead
  # Then, you can remove it from this and the units test.
  include AuthenticatedTestHelper

  fixtures :employees

  def test_should_allow_signup
    assert_difference 'Employee.count' do
      create_employee
      assert_response :redirect
    end
  end

  def test_should_require_login_on_signup
    assert_no_difference 'Employee.count' do
      create_employee(:login => nil)
      assert assigns(:employee).errors.on(:login)
      assert_response :success
    end
  end

  def test_should_require_password_on_signup
    assert_no_difference 'Employee.count' do
      create_employee(:password => nil)
      assert assigns(:employee).errors.on(:password)
      assert_response :success
    end
  end

  def test_should_require_password_confirmation_on_signup
    assert_no_difference 'Employee.count' do
      create_employee(:password_confirmation => nil)
      assert assigns(:employee).errors.on(:password_confirmation)
      assert_response :success
    end
  end

  def test_should_require_email_on_signup
    assert_no_difference 'Employee.count' do
      create_employee(:email => nil)
      assert assigns(:employee).errors.on(:email)
      assert_response :success
    end
  end
  

  

  protected
    def create_employee(options = {})
      post :create, :employee => { :login => 'quire', :email => 'quire@example.com',
        :password => 'quire69', :password_confirmation => 'quire69' }.merge(options)
    end
end
