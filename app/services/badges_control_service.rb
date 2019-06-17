class BadgesControlService

  def initialize(test_passage)
    @test_passage = test_passage
    @user = test_passage.user
  end

  def call
    return unless @test_passage.success?
    Badge.all.select { |badge| send("rule_#{badge.title}")}
  end

  private

  def rule_first_attempt
    TestPassage.where(user_id: @user.id, test_id: @test_passage.test.id).count == 1
  end

  def rule_all_by_category
    all_tests_by_category = Test.test_category(@test_passage.test.category_id).ids
    tests_from_test_passage = successful_tests_ids
    all_tests_by_category - tests_from_test_passage == []
  end

  def rule_all_by_level
    all_tests_by_level = Test.test_level(@test_passage.test.level).ids
    tests_from_test_passage = successful_tests_ids
    all_tests_by_level - tests_from_test_passage == []
  end

  def successful_tests
    @user.test_passages.finished.select { |test_passage| test_passage.success? }
  end

  def successful_tests_ids
    successful_tests.map { |test_passage| test_passage.test_id }
  end
end
