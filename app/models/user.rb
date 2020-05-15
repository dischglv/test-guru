class User < ApplicationRecord
  has_many :results, dependent: :destroy
  has_many :tests, through: :results
  has_many :created_tests, inverse_of: :author, class_name: "Test",
            dependent: :nullify, foreign_key: "author_id"

  validates :email, presence: true
  
  def tests_by_level(level)
    tests.where(level: level)
  end
end
