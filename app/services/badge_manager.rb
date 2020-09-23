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

    @last_date_category = TestPassage.all.order(created_at: :asc).select(:created_at).first
    @last_date_level = @last_date_category
  end


  def award_badges(test_passage)
    @test_passage = test_passage

    Badge.all.select { |badge| 
      send("#{badge.rule}?", badge) }
  end

  private

  def all_from_category?(badge)
    category = @current_test.category
    return unless @test_passage.passed? && category ==  badge.rule_value

    tests_from_category = Test.where(category: category).select(:id).order(:id)
    passed_tests = TestPassage.where(user_id: @current_user.id, 
                    created_at: @last_date_category..Time.current)
                   .joins(:test)
                   .where(tests: { category: category }, passed: true )
                   .select(:id)
                   .distinct
                   .order(:id)

    if passed_tests == tests_from_category
      @last_date_category = get_last_date("category", category)
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

    tests_of_level = Test.where(level: level).select(:id).order(:id)
    passed_tests = TestPassage.where(user_id: @current_user.id,
                    created_at: @last_date_level..Time.current)
                   .joins(:test)
                   .where(tests: { level: level }, passed: true)
                   .select(:id)
                   .distinct
                   .order(:id)
    
    if tests_of_level == passed_tests
      @last_date_level = get_last_date("level", level)
      true
    else
      false
    end
  end

  def get_last_date(attribute, value)
    TestPassage.where(user_id: @current_user.id)
               .joins(:test)
               .where(tests: { "#{attribute}" => value}, passed: true)  
               .select(:created_at)
               .order(created_at: :asc)
               .last
  end
  
end