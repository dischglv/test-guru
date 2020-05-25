module TestsHelper

  TEST_LEVELS = {
    0 => 'очень легкий',
    1 => 'легкий',
    2 => 'непростой',
    3 => 'сложный',
    4 => 'очень сложный'
  }.freeze

  def test_level(test)
    TEST_LEVELS[test.level] || 'очень легкий'
  end
end
