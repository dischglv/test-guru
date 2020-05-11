class User < ApplicationRecord
  has_many :results
  has_many :tests, through: :results
  has_many :created_tests, inverse_of: :author, class_name: "Test"

  def tests_by_level(level)
    Test.joins(:results)
        .where(results: { user_id: self.id }, level: level)
  end
end
