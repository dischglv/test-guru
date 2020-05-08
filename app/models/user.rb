class User < ApplicationRecord
  def tests_by_level(level)
    Test.joins('JOIN results ON results.test_id = tests.id')
        .where(results: { user_id: self.id }, level: level)
  end
end
