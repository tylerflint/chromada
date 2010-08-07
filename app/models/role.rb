class Role < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :actions
  belongs_to :company
end
