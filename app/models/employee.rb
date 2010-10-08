class Employee
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name
  field :employee_number
  field :email
  field :notes
  index :name
  index :employee_number
  index :email
  
  embedded_in :company, :inverse_of => :employees
end
