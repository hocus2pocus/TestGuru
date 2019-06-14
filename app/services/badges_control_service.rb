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
    # limit_date = previous_badge_date(@all_by_category) || @user.created_at

    # category = @test_passage.test.category_id
    # all_tests_by_category = Test.where(category_id: category).ids

    # tests_from_test_passage = []
    # test_passages = TestPassage.where(user_id: @user.id, current_question_id: nil, created_at: limit_date..Time.current)
    # test_passages.each { |t| tests_from_test_passage << t.test_id }

    # all_tests_by_category - tests_from_test_passage == []

    all_tests_by_category = Test.test_category(@test_passage.test.category_id).ids
    tests_from_test_passage = successful_tests_ids
    all_tests_by_category - tests_from_test_passage == []

  end

  def rule_all_by_level
    #current_budges = AchievedBadge.where(user_id: @user.id,)
    # limit_date = previous_badge_date(@all_by_level) || @user.created_at

    # level = @test_passage.test.level
    # all_tests_by_level = Test.where(level: level).ids

    # tests_from_test_passage = []
    # test_passages = TestPassage.where(user_id: @user.id, current_question_id: nil, created_at: limit_date..Time.current)
    # test_passages.each { |t| tests_from_test_passage << t.test_id }

    # all_tests_by_level - tests_from_test_passage == []

    all_tests_by_level = Test.test_level(@test_passage.test.level).ids
    tests_from_test_passage = successful_tests_ids
    all_tests_by_level - tests_from_test_passage == []
  end

  # def achieve_first_attempt
  #   AchievedBadge.create!(user: @user, badge: @first_attempt, description: "For #{@test_passage.test.title}")
  # end

  # def achieve_all_by_category
  #   AchievedBadge.create!(user: @user, badge: @all_by_level, description: "For all tests in #{@test_passage.test.category.title} category")
  # end

  # def achieve_all_by_level
  #   AchievedBadge.create!(user: @user, badge: @all_by_level, description: "For all tests #{@test_passage.test.level} level")
  # end

  # def previous_badge_date(badge)
  #   case badge
  #   when @all_by_category
  #     description = "For all tests in #{@test_passage.test.category.title} category"
  #   when @all_by_level
  #     description = "For all tests #{@test_passage.test.level} level"
  #   end

  #   last_existent_badge = AchievedBadge.order(:created_at).where(user_id: @user.id, description: description).last

  #   if last_existent_badge
  #     last_existent_badge.created_at
  #   end
  # end

  def successful_tests
    @user.test_passages.finished.select { |test_passage| test_passage.success? }
  end

  def successful_tests_ids
    successful_tests.map { |test_passage| test_passage.test_id }
  end
end
