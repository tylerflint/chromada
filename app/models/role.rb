class Role < ActiveRecord::Base
  has_many    :resources
  belongs_to  :company
  has_and_belongs_to_many :employees
end
