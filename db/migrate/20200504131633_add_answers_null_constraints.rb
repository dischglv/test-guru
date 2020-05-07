class AddAnswersNullConstraints < ActiveRecord::Migration[6.0]
  def change
    change_column_null(:answers, :answer_text, false)
    change_column_null(:answers, :question_id, false)
  end
end
