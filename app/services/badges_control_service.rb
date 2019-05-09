class BadgesControlService

  def initialize(test_passage)
    @test_passage = test_passage
    @user = test_passage.user

    badges_model_check
  end

  def call
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
  end

  def rule_all_by_level
  end
end
