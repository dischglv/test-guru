module AnswersHelper

  def answer_correct(answer)
    if answer.correct
      'Верный'
    else
      'Не верный'
    end
  end
end
