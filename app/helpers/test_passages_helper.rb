module TestPassagesHelper

  def test_progress(test_passage)
    current_question_number = test_passage.test.number_of_questions - test_passage.count_remaining

    "#{current_question_number}/#{test_passage.test.number_of_questions}"
  end

  def successful_pass?(test_passage)
    test_passage.stats > 85
  end

end
