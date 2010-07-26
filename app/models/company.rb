class Company
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, :type => String
  
  # kinda stupid, but this is required for the users side... maybe I should submit a feature request
  references_many :users, :stored_as => :array, :inverse_of => :companies
end
