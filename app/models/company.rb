class Company
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name
  field :owners, :type => Array
  
  index :name
  
  embeds_many :employees
  
  references_many :permissions, :dependant => :destroy
  
  references_many \
    :users, 
    :stored_as => :array, 
    :inverse_of => :companies,
    :index => true,
    :dependant => :remove
  
  def is_owner?(user)
    owners.include?(user.id)
  end
  
  def add_owner(owner)
    if self.owners
      self.owners << owner.id unless self.owners.include?(owner.id)
    else
      self.owners = [owner.id]
    end
    add_user(owner)
  end
  
  def add_user(user)
    self.users << user unless self.user_ids.include?(user.id); self
  end
  
  def drop_user(user)
    self.user_ids = self.user_ids - [user.id]
    self.owners   = self.owners - [user.id] if self.owners
  end
  alias :drop_owner :drop_user
  
  def permission_ids
    self.permissions.inject([]) {|ids, permission| ids << permission.id}
  end
  
end
