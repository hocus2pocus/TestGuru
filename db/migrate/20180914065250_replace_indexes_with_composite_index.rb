class ReplaceIndexesWithCompositeIndex < ActiveRecord::Migration[5.2]
  def self.up
    remove_index :tests_users, :test_id
    remove_index :tests_users, :user_id
    add_index :tests_users, [:user_id, :test_id], unique: true
  end

  def self.down
    remove_index :tests_users, [:user_id, :test_id], unique: true
    add_index :tests_users, :test_id
    add_index :tests_users, :user_id
  end
end
