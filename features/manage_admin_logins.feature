Feature: Manage admin_logins
  In order to use the admin panel
  As an employee
  I want to login and logout
  
	Scenario: Employee successfully logins in
		Given I am currently not logged in
		When I click the login link
		And Enter my credentials admin@chromada.com, password
		Then I am redirected to the admin dashboard
		
	Scenario: Employee unsuccessfully logs in
		Given I am currently not logged in
		When I click the login link
		And Enter the credentials admin@chromada.com, wrong
		Then I am not redirected to the admin dashboard
		And I am shown an error message
		
	Scenario: Employee logs out
		Given I am currently logged in
		When I click logout
		Then I am redirected to the homepage
		And My admin session is cleared
