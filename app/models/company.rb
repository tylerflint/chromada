class Company
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name
  index :name
  
  embeds_many :employees
  embeds_many :permissions
  references_many \
    :users, 
    :stored_as => :array, 
    :inverse_of => :companies,
    :index => true
  
  
  
end
