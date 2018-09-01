class CreateTests < ActiveRecord::Migration[5.2]
  def change
    create_table :tests do |t|
      t.string :title
      t.integer :level
      t.string :category_id
      t.string :integer

      t.timestamps
    end
  end
end
