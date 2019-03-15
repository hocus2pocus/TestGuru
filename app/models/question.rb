class Question < ApplicationRecord
  belongs_to :test
  has_many :answers, dependent: :destroy
  has_many :gists

  validates :body, presence: true

  # validate :validate_answers

  private

  # def validate_answers
  #   errors.add(:question) if (1..4).include?(answers.count)
  # end
end
