module TestPassagesHelper
  def result_style(test_passage)
    test_passage.success? ? 'success' : 'fail'
  end

  def test_result(test_passage)
    test_passage.success? ? t('.success') : t('.fail')
  end

  def question_count_text(test_passage)
    "#{test_passage.question_number} of #{test_passage.test.questions.size}"
  end
end
