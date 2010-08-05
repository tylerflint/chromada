class Employee < ActiveRecord::Base
  belongs_to :company
  
  def name
    [firstname, lastname].join " "
  end
end
