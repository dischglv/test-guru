class BadgeManager

  def award_badges(test_passage)
    @test_passage = test_passage

    Badge.all.select { |badge| 
      @badge = badge
      send("#{badge.rule}?", badge) }
  end

  private

  def all_from_category?(badge)
    current_test = @test_passage.test
    category = current_test.category
    return unless @test_passage.passed? || category ==  badge.category

    tests_from_category = Test.where(category: category).select(:id).order(:id)
    passed_tests = TestPassage.where(id: current_test.id)
                   .joins(:test)
                   .where(tests: { category: category }, passed: true )
                   .distinct
                   .select(:id)
                   .order(:id)

    passed_tests == tests_from_category
  end

  def first_try?(badge)
    current_test = @test_passage.test

    passed_tests = TestPassage.where(test: test, passed: true)
                    .count

    passed_tests == 1
  end

  def all_of_level?(badge)
    current_test = @test_passage.test
    level = current_test.level
    return unless @test_passage.passed? || level ==  badge.level

    tests_of_level = Test.where(level: level).select(:id).order(:id)
    passed_tests = TestPassage.where(id: current_test.id)
                   .joins(:test)
                   .where(tests: { level: level }, passed: true)
                   .distinct
                   .select(:id)
                   .order(:id)
    
    tests_of_level == passed_tests
  end
end