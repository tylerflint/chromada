class Employee
  include Mongoid::Document
  include Mongoid::Timestamps
  field :firstname, :type => String
  field :lastname, :type => String
  field :employee_number, :type => String
  field :is_active, :type => Integer
  field :notes, :type => Array
  embedded_in :company, :inverse_of => :employees
end
