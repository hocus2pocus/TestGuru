class RenameResultsToTestsUsers < ActiveRecord::Migration[5.2]
  def self.up
    remove_index :results, :test_id
    remove_index :results, :user_id
    rename_table :results, :tests_users
    add_index :tests_users, :test_id
    add_index :tests_users, :user_id
  end

  def self.down
    remove_index :tests_users, :test_id
    remove_index :tests_users, :user_id
    rename_table :tests_users, :results
    add_index :results, :test_id
    add_index :results, :user_id
  end
end
