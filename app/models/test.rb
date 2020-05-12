class Test < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: "User", foreign_key: "author_id"
  has_many :questions, dependent: :destroy
  has_many :results, dependent: :destroy
  has_many :users, through: :results

  def self.names_by_category(category_name)
    Test.joins(:categories)
        .where(categories: { title: category_name })
        .order(title: :desc)
        .pluck(:title)
  end
end
