class TestPassage < ApplicationRecord
  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :before_validation_set_current_question

  def current_progress
    (100 * (current_question_number - 1) / test.number_of_questions).round
  end

  def current_question_number
    test.questions.order(:id).where('id <= :question_id', question_id: current_question.id).count
  end

  def success?
    stats > 85
  end

  def stats
    (correct_questions * 100 / test.number_of_questions).round
  end

  def completed?
    current_question.nil?
  end
  
  def accept!(answer_ids)
    if correct_answer?(answer_ids)
      self.correct_questions += 1
    end

    self.passed = true if success? 
    
    current_question = nil if time_over?
    save!
  end

  def timer
    test.timer
  end

  def time_over?
    created_at - Time.now + timer * 60 <= 0
  end
  
  private

  def before_validation_set_current_question
    self.current_question = next_question
  end
  
  def correct_answer?(answer_ids)
    return false unless answer_ids.present?
    correct_answers.ids.sort == answer_ids.map(&:to_i).sort
  end
  
  def correct_answers
    current_question.answers.correct
  end
  
  def next_question
    remaining_questions.first
  end
  
  def remaining_questions
    current_question_id = current_question.nil? ? -1 : current_question.id
    
    test.questions.order(:id).where('id > :question_id', question_id: current_question_id)
  end

end
