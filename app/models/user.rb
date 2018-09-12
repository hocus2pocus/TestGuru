class User < ApplicationRecord
  has_many :tests_users
  has_many :tests, through: :tests_users
  def tests_by_level(level)
    Test.joins('JOIN tests_users ON tests_users.test_id = tests.id').where(tests_users: {user_id: self.id}, level: level)
  end
end
