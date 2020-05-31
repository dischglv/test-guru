class Question < ApplicationRecord
  belongs_to :test
  has_many :answers, dependent: :destroy
  has_many :test_passages, foreign_key: :current_question_id, dependent: :nullify

  validates :question_text, presence: true
end
