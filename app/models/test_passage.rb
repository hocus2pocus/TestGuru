class TestPassage < ApplicationRecord
  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :before_validation_set_question

  def completed?
    current_question.nil? #&& Time.current <= self.time_finish
  end

  def accept!(answer_ids)
    self.correct_questions += 1 if correct_answer?(answer_ids)
    save!
  end

  def percent_of_correct_answers
    correct_questions.to_f / test.questions.count * 100
  end

  def success?
    percent_of_correct_answers >= 85
  end

  def question_number
    test.questions.where('id < ?', current_question.id).count + 1
  end

  def stop_passage
    current_question = nil
  end

  def time_limit
    test.time_limit * 60
  end

  def time_finish
    self.created_at + time_limit
  end

  def time_left
    time_finish - Time.current
  end

  private

  def before_validation_set_question
    self.current_question = next_question
  end

  def correct_answer?(answer_ids)
    correct_answers_count = correct_answers.count

    (correct_answers_count == correct_answers.where(id: answer_ids).count) &&
    (correct_answers_count == answer_ids.count)
  end

  def correct_answers
    current_question.answers.correct
  end

  def next_question
    if current_question
      test.questions.order(:id).where('id > ?', current_question.id).first
    else
      test.questions.first if test.present?
    end
  end

  scope :finished, -> { where(current_question_id: nil) }
end
