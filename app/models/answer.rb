class Answer < ApplicationRecord
  belongs_to :question

  validates :body, presence: true
  validate :validate_answers_quantity, on: :create

  scope :correct, -> { where(correct: true) }

# def with_backtrace
#  yield
# rescue => e
#  puts "Error class - #{e.class}"
#  puts "Error message - #{e.message}"
#  puts e.backtrace
# end

  private

  def validate_answers_quantity
     errors.add(:question_id, 'Invalid number of answers') if question.answers.count >= 4
  end


end
