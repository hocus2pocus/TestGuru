class Answer < ApplicationRecord
  belongs_to :question

  validates :body, presence: true
  validate :validate_answers_quantity

  scope :correct, -> { where(correct: true) }

  private

  def validate_answers_quantity
    #errors.add(:answer) if (1..4).include?(self.question.answers.count)
    errors.add(:answer) if question.answers.count > 4
  end
end
