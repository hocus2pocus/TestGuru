class Test < ApplicationRecord
  def self.sorted_by_category(category)
    self.joins('JOIN categories ON tests.category_id = categories.id')
      .where(categories: { title: category })
      .order(id: :DESC)
      .pluck(:title)
  end
end
