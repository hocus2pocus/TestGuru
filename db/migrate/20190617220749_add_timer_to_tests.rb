class AddTimerToTests < ActiveRecord::Migration[5.2]
  def change
    add_column :tests, :time_limit, :integer, null: false, default: 0
  end
end
