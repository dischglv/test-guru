class BadgeManager

  BADGE_TYPES = [
    :all_from_category,
    :all_of_level, 
    :first_try 
  ]

  def initialize(test_passage)
    @test_passage = test_passage
    @current_test = test_passage.test
    @current_user = test_passage.user
  end


  def award_badges
    Badge.all.select { |badge| 
      send("#{badge.rule}?", badge) }
  end

  private

  def all_from_category?(badge)
    category = @current_test.category
    return unless @test_passage.passed? && category ==  badge.rule_value

    tests_from_category = Test.where(category: category).select(:id).order(:id).pluck(:test_id)
    passed_tests = TestPassage.where(user_id: @current_user.id, 
                    created_at: get_last_award_date(badge.rule.to_s)..Time.current)
                   .joins(:test)
                   .where(tests: { category: category }, passed: true )
                   .select(:test_id)
                   .distinct
                   .order(:test_id)
                   .pluck(:test_id)

    passed_tests == tests_from_category
  end

  def first_try?(badge)
    passed_tests = TestPassage.where(test: @current_test, passed: true)
                    .count

    passed_tests == 1
  end

  def all_of_level?(badge)
    level = @current_test.level
    return unless @test_passage.passed? || level ==  badge.rule_value

    tests_of_level = Test.where(level: level).select(:id).order(:id).pluck(:id)
    passed_tests = TestPassage.where(user_id: @current_user.id,
                    created_at: get_last_award_date(badge.rule.to_s)..Time.current)
                   .joins(:test)
                   .where(tests: { level: level }, passed: true)
                   .select(:test_id)
                   .distinct
                   .order(:test_id)
                   .pluck(:test_id)
    
    tests_of_level == passed_tests
  end

  def get_last_award_date(rule)
    # if @current_user.badges.any? { |badge| badge.rule == rule.to_s}
      last_badge = UserBadge.where(user_id: @current_user.id)
                                           .joins(:badge)
                                           .where(rule: rule)
                                           .order(created_at: :desc)
                                           .first
      
      last_badge ? last_badge.created_at : Time.new("00-00-00")
  end  
end