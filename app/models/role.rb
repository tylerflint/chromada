class Role < ActiveRecord::Base
  has_many :resources
end
