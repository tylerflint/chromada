class User
  include Mongoid::Document
  include Mongoid::Timestamps
  
  references_many \
    :permissions, 
    :stored_as => :array, 
    :inverse_of => :users,
    :index => true
  references_many \
    :companies, 
    :stored_as => :array, 
    :inverse_of => :users,
    :index => true

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :username, :password, :password_confirmation
  
  def name
    self.username
  end
  
  def set_permissions(company, permissions)
    self.permission_ids = self.permission_ids - company.permission_ids
    self.permission_ids = self.permission_ids | permissions
  end
  
end
