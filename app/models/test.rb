class Test < ApplicationRecord
  has_many :questions
  has_many :results
  has_many :users, through: :results
  belongs_to :category
  belongs_to :author, class_name: "User", foreign_key: "author_id"

  def self.names_by_category(category_name)
    Test.joins(:categories)
        .where(categories: { title: category_name })
        .order(title: :desc)
        .pluck(:title)
  end
end
