class CreateResults < ActiveRecord::Migration[5.2]
  def change
    create_table :results do |t|
      t.references :user, foreign_key: true
      t.references :test, foreign_key: true
      t.integer :result, default: 0

      t.timestamps
    end
  end
end
