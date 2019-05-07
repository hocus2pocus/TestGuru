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
  end

  def default_bages
    @first_attempt = Badge.find_by(title: 'First attempt')
  end

  def rule_first_attempt
    TestPassage.where(user_id: @user.id, test_id: @test_passage.test.id).count == 1
  end
end
