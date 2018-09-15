class RenameResultsToTestsUsers < ActiveRecord::Migration[5.2]
  def self.up
    rename_table :results, :tests_users
  end

  def self.down
    rename_table :tests_users, :results
  end
end
