class CreateRelationsBetweenModels < ActiveRecord::Migration[5.2]
  def change
    remove_column :tests, :integer
    change_column :tests, :category_id, 'integer USING CAST(category_id AS integer)'

    add_foreign_key :tests, :categories
    add_foreign_key :questions, :tests
    add_foreign_key :answers, :questions
  end
end
