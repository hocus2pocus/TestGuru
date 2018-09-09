class Test < ApplicationRecord
  # Создайте метод класса в модели Test, который возвращает отсортированный по убыванию массив названий всех Тестов у которых Категория называется определённым образом (название категории передается в метод в качестве аргумента).

  def self.sort_test_by_category(category)
    self.joins('JOIN categories ON tests.category_id = categories.id').where('categories.title = ?', category)
  end

  class << self
    alias :stbc :sort_test_by_category
  end
end
