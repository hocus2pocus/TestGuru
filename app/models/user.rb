class User < ApplicationRecord
  def tests_by_level(level)
    Test.joins('JOIN results ON results.test_id = tests.id').where('user_id = ? AND level = ?', self.id, level)
  end

  alias_method :tbl, :tests_by_level
end

# Создайте инстанс-метод в модели User, который принимает в качестве аргумента значение уровня сложности и возвращает список всех Тестов, которые проходит или когда-либо проходил Пользователь на этом уровне сложности
