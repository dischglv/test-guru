class Test < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :author, class_name: "User", foreign_key: "author_id", optional: true
  has_many :questions, dependent: :destroy
  has_many :test_passages, dependent: :destroy
  has_many :users, through: :test_passages

  validates :title, presence: true
  validates :level, numericality: { only_integer: true,
                                    greater_than_or_equal_to: 0 }
  validates :title, uniqueness: {scope: :level}

  scope :easy_tests, -> { where(level: 0..1) }
  scope :medium_tests, -> { where(level: 2..4) }
  scope :hard_tests, -> { where(level: 5..Float::INFINITY) }
  scope :by_category, ->(category_name) { joins(:category)
                                          .where(categories: { title: category_name })
                                          .order(title: :desc)
                                        }

  def self.names_by_category(category_name)
    by_category(category_name).pluck(:title)
  end

  def number_of_questions
    questions.count
  end
  
end
