class BadgesControlService

  def initialize(test_passage)
    @test_passage = test_passage
    @user = test_passage.user

    badges_model_check
  end

  def call
    return unless @test_passage.success?
    achieve_first_attempt if rule_first_attempt
    # achieve_all_by_category if rule_all_by_category
    achieve_all_by_level if rule_all_by_level
  end

  private

  def badges_model_check
    default_bages
    @first_attempt ||= Badge.create!(title: 'First attempt', picture: "red-badge")
    @all_by_category ||= Badge.create!(title: 'All by category', picture: "green-badge")
    @all_by_level ||= Badge.create!(title: 'All by level', picture: "pink-badge")
  end

  def default_bages
    @first_attempt = Badge.find_by(title: 'First attempt')
    @all_by_category = Badge.find_by(title: 'All by category')
    @all_by_level = Badge.find_by(title: 'All by level')
  end

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
  end

  def rule_all_by_level
    #current_budges = AchievedBadge.where(user_id: @user.id,)
    limit_date = previous_badge_date(@all_by_level) || @user.created_at

    level = @test_passage.test.level
    all_tests_by_level = Test.where(level: level).ids

    tests_from_test_passage = []
    test_passages = TestPassage.where(user_id: @user.id, current_question_id: nil, created_at: limit_date..Time.current)
    test_passages.each { |t| tests_from_test_passage << t.test_id }

    all_tests_by_level - tests_from_test_passage == []
  end

  def achieve_first_attempt
    AchievedBadge.create!(user: @user, badge: @first_attempt, description: "For #{@test_passage.test.title}")
  end

  def achieve_all_by_category
    AchievedBadge.create!(user: @user, badge: @all_by_level, description: "For all tests in #{@test_passage.test.category.title} category")
  end

  def achieve_all_by_level
    AchievedBadge.create!(user: @user, badge: @all_by_level, description: "For all tests #{@test_passage.test.level} level")
  end

  def previous_badge_date(badge)
    case badge
    when @all_by_category
      description = "For all tests in #{@test_passage.test.category.title} category"
    when @all_by_level
      description = "For all tests #{@test_passage.test.level} level"
    end

    last_existent_badge = AchievedBadge.order(:created_at).where(user_id: @user.id, description: description).last

    if last_existent_badge
      last_existent_badge.created_at
    end
  end
end
