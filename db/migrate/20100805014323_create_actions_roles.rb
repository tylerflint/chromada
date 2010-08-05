class CreateActionsRoles < ActiveRecord::Migration
  def self.up
    create_table :actions_roles, :id => false do |t|
      t.integer :action_id
      t.integer :role_id
    end
    
    add_index :actions_roles, :action_id
    add_index :actions_roles, :role_id
  end

  def self.down
    drop_table :actions_roles
  end
end
