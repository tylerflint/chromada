class User
  include Mongoid::Document
  include Mongoid::Timestamps
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  # references_many :companies, :stored_as => :array, :inverse_of => :users
  # references_many :companies, :stored_as => :array
end
