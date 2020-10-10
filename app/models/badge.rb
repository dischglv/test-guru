class Badge < ApplicationRecord
  has_many :user_badges, dependent: :destroy
  has_many :users, through: :user_badges

  validates :name, :img_url, presence: true
  validates :rule, inclusion: { in: BadgeManager::BADGE_TYPES.map(&:to_s) }
  validates_uniqueness_of :rule_value, scope: :rule
end
