class Answer < ApplicationRecord
  belongs_to :question

  validates :answer_text, presence: true
  validate :max_number_of_answers, on: :create

  scope :correct, -> { where(correct: true) }

  private

  def max_number_of_answers
    errors.add(:base) if question.answers.count >= 4
  end
end
