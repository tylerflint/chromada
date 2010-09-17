class User < ActiveRecord::Base

  has_and_belongs_to_many :companies
  has_and_belongs_to_many :permissions

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation
  
  def name
    self.username
  end
  
  def set_permissions(company, permissions)
    self.permission_ids = self.permission_ids - company.permission_ids
    self.permission_ids = self.permission_ids | permissions
  end
  
end
