class CreateAchievedBadges < ActiveRecord::Migration[5.2]
  def change
    create_table :achieved_badges do |t|
      t.references :user, foreign_key: true, null: false
      t.references :badge, foreign_key: true, null: false
      t.text :description, null: false

      t.timestamps
    end
  end
end
