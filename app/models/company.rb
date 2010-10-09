class Company
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name
  field :owners, :type => Array
  index :name
  
  embeds_many :employees
  embeds_many :permissions
  references_many \
    :users, 
    :stored_as => :array, 
    :inverse_of => :companies,
    :index => true
  
  def is_owner?(user)
    owners.include?(user.id)
  end
  
end
