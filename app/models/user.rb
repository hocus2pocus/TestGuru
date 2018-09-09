class User < ApplicationRecord
  def tests_by_level(level)

    user_tests = []
    Result.where(user_id: self.id).select(:id, :test_id).each { |t| user_tests << t[:test_id]}
    user_tests.each do |test|
      Test.where(id: test, level: level)
    end



  end

  alias_method :tbl, :tests_by_level
end

# Создайте инстанс-метод в модели User, который принимает в качестве аргумента значение уровня сложности и возвращает список всех Тестов, которые проходит или когда-либо проходил Пользователь на этом уровне сложности
