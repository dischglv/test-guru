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

    @last_awarded_date_level = update_last_awarded_date("level")
    @last_awarded_date_category = update_last_awarded_date("category")
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
                    created_at: @last_awarded_date_category..Time.current)
                   .joins(:test)
                   .where(tests: { category: category }, passed: true )
                   .select(:test_id)
                   .distinct
                   .order(:test_id)
                   .pluck(:test_id)

    if passed_tests == tests_from_category
      @last_awarded_date_category = update_last_awarded_date("category")
      true
    else
      false
    end
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
                    created_at: @last_awarded_date_level..Time.current)
                   .joins(:test)
                   .where(tests: { level: level }, passed: true)
                   .select(:test_id)
                   .distinct
                   .order(:test_id)
                   .pluck(:test_id)
    
    if tests_of_level == passed_tests
      @last_awarded_date_level = update_last_awarded_date("level")
      true
    else
      false
    end
  end

  def update_last_awarded_date(attribute)
    if attribute == "category"
      rule = "all_from_category"
    else
      rule = "all_of_level"
    end

    if @current_user.badges.any? { |badge| badge.rule == rule.to_s}
      UserBadges.where(user_id: @current_user.id)
                                           .join(:badges)
                                           .where(rule: rule)
                                           .order(created_at: :desc)
                                           .limit(1)
                                           .created_at
    else
      TestPassage.all.order(created_at: :asc).first.created_at
    end
  end  
end