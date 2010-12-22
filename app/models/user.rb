class User
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :email
  index :email

  references_many \
    :permissions, 
    :stored_as => :array,
    :inverse_of => :users,
    :index => true
    
  references_many \
    :companies, 
    :stored_as => :array, 
    :inverse_of => :users,
    :index => true,
    :dependant => :remove

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation
  
  validates_presence_of :email
  validates_presence_of :password, :on => :create
  validates_uniqueness_of :email
  
  def name
    self.username
  end
  
  def set_permissions(company, permission_ids)
    # company_permission_ids = company.permission_ids
    # permission_ids = permission_ids.inject([]) do |valid, permission_id| 
    #   valid << permission_id if company_permission_ids.include?(permission_id); valid
    # end
    loaded_permissions   = self.permissions
    company_permissions  = company.permissions
    stripped_permissions = []
    loaded_permissions.each do |loaded_permission|
      match = false
      company.permissions.each do |company_permission|
        match = true if loaded_permission.id == company_permission.id
      end
      stripped_permissions << loaded_permission unless match
    end
    self.permission_ids = stripped_permissions | permission_ids
  end
  
  def drop_company(company)
    self.company_ids = self.company_ids - [company.id]
  end
  
end
