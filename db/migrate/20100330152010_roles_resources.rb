class RolesResources < ActiveRecord::Migration
  def self.up
    create_table :roles_resources do |t|
      t.references :roles
      t.references :resources
    end
  end

  def self.down
    drop_table :roles_resources
  end
end
