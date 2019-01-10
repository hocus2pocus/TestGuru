require 'digest/sha1'

class User < ApplicationRecord

  attr_reader :password
  attr_writer :password_confirmation

  has_many :test_passages
  has_many :tests, through: :test_passages
  has_many :created_tests, class_name: "Test", foreign_key: "author_id"

  validates :email, presence: true
  validates :password, presence: true, if: Proc.new { |u| u.password_digest.blank? }
  validates :password, confirmation: true

  def tests_by_level(level)
    tests.where(level: level)
    #Test.joins('JOIN tests_users ON tests_users.test_id = tests.id').where(tests_users: {user_id: self.id}, level: level)
  end

  def test_passage(test)
    #ordered to take exactly the last test that user passed
    test_passages.order(id: :desc).find_by(test: test)
  end

  def authenticate(password_string)
    digest(password_string) == self.password_digest ? self : false
  end

  def password=(password_string)
    if password_string.nil?
      self.password_digest = nil
    elsif password_string.present?
      @password = password_string
      self.password_digest = digest(password_string)
    end
  end

  private

  def digest(string)
    Digest::SHA1.hexdigest(string)
  end
end
