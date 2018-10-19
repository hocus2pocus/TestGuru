class User < ApplicationRecord
  has_many :tests_passeges
  has_many :tests, through: :tests_passeges
  has_many :created_tests, class_name: "Test", foreign_key: "author_id"

  validates :email, presence: true

  def tests_by_level(level)
    tests.where(level: level)
    #Test.joins('JOIN tests_users ON tests_users.test_id = tests.id').where(tests_users: {user_id: self.id}, level: level)
  end
end
