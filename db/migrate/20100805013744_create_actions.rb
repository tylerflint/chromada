class CreateActions < ActiveRecord::Migration
  def self.up
    create_table :actions do |t|
      t.string :path

      t.timestamps
    end
    add_index :actions, :path
  end

  def self.down
    drop_table :actions
  end
end
