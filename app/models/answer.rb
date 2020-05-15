class Answer < ApplicationRecord
  belongs_to :question

  validates :answer_text, presence: true
  validate :max_number_of_answers

  scope :correct, -> { where(correct: true) }

  private

  def max_number_of_answers
    errors.add(:base) if Answer.where(question_id: question_id).count >= 4
  end
end
