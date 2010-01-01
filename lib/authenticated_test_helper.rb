module AuthenticatedTestHelper
  # Sets the current employee in the session from the employee fixtures.
  def login_as(employee)
    @request.session[:employee_id] = employee ? (employee.is_a?(Employee) ? employee.id : employees(employee).id) : nil
  end

  def authorize_as(employee)
    @request.env["HTTP_AUTHORIZATION"] = employee ? ActionController::HttpAuthentication::Basic.encode_credentials(employees(employee).login, 'monkey') : nil
  end
  
end
