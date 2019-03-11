class CreateGists < ActiveRecord::Migration[5.2]
  def change
    create_table :gists do |t|
      t.references :user, foreign_key: true, null: false
      t.references :test, foreign_key: true, null: false
      t.references :current_question, foreign_key: { to_table: :questions }, null: false
      t.string :url, null: false

      t.timestamps
    end
  end
end
