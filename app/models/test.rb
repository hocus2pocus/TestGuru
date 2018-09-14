class Test < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: "User"
  has_many :questions
  has_many :tests_users
  has_many :users, through: :tests_users

  def self.sorted_by_category(category)
    self.joins('JOIN categories ON tests.category_id = categories.id')
      .where(categories: { title: category })
      .order(id: :desc)
      .pluck(:title)
  end
end
