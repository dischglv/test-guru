module TestPassagesHelper

  def test_progress(test_passage)
    "#{test_passage.current_question_number}/#{test_passage.test.number_of_questions}"
  end

end
