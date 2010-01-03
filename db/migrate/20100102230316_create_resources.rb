class CreateResources < ActiveRecord::Migration
  def self.up
    create_table :resources do |t|
      t.integer     :role_id
      t.string      :path
      t.timestamps
    end
    add_index :resources, :path
  end

  def self.down
    drop_table :resources
  end
end
