class Company
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, :type => String
  
  # references_many :users, :inverse_of => :companies
  # referenced_in :user, :inverse_of => :companies
end
