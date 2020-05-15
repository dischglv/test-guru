class Test < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :author, class_name: "User", foreign_key: "author_id", optional: true
  has_many :questions, dependent: :destroy
  has_many :results, dependent: :destroy
  has_many :users, through: :results

  validates :title, presence: true
  validates :level, numericality: { only_integer: true,
                                    greater_than_or_equal_to: 0 }
  validates :title, uniqueness: {scope: :level}

  scope :tests_by_level, lambda { |level|
    case level
    when :easy
      where(level: 0..1)
    when :medium
      where(level: 2..4)
    when :hard
      where(level: 5..Float::INFINITY)
    end
  }

  scope :names_by_category, ->(category_name) { joins(:category)
                                                .where(categories: { title: category_name })
                                                .order(title: :desc)
                                                .pluck(:title) 
                                              }
end
