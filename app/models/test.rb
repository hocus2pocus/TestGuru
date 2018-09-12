class Test < ApplicationRecord
  belongs_to :category
  has_many :questions

  def self.sorted_by_category(category)
    self.joins('JOIN categories ON tests.category_id = categories.id')
      .where(categories: { title: category })
      .order(id: :desc)
      .pluck(:title)
  end
end
