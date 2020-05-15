class Question < ApplicationRecord
  belongs_to :test
  has_many :answers, dependent: :destroy

  validates :question_text, presence: true
  validates :answers, length: { minimum: 1, maximum: 4,
                                message: 'Количество ответов должно быть от 1 до 4' }
end
