class Test < ApplicationRecord
  def self.names_by_category(category_name)
    # category_id = Category.find(title: category_name).id
    Test.joins('JOIN categories ON categories.id = tests.category_id')
        .where(categories: { title: category_name })
        .order(title: :desc)
        .pluck(:title)
  end
end
