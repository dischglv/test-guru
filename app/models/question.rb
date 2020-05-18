class Question < ApplicationRecord
  belongs_to :test
  has_many :answers, dependent: :destroy

  validates :question_text, presence: true
end
