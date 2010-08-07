class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.integer :company_id
      t.string :name

      t.timestamps
    end
    
    add_index :roles, :company_id
    add_index :roles, :name
  end

  def self.down
    drop_table :roles
  end
end
