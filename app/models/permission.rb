class Permission
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name
  index :name
  
  referenced_in :company
  
  references_many \
    :actions, 
    :stored_as => :array, 
    :inverse_of => :permissions,
    :index => true

  references_many \
    :users,
    :stored_as => :array, 
    :inverse_of => :permissions,
    :index => true
  
end
