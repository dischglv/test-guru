class Badge < ApplicationRecord
  has_many :user_badges, dependent: :destroy
  has_many :users, through: :user_badges
  has_one :category

  validates :name, :img_url, presence: true
  validates :rule, inclusion: { in: ['all_from_category', 'first_try', 'all_of_level'] }
  validates_uniqueness_of :category
  validates_uniqueness_of :level, scope: :rule
end
