class QuestionsController < ApplicationController

  before_action :find_test, only: %i[index create]
  before_action :find_question, only: %i[show destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found
  
  def index
    result = "Все вопросы теста:\n"
    @test.questions.each_with_index do |question, index|
      result += "[#{index + 1}]: #{question.question_text}\n ID: #{question.id}\n"
    end

    render plain: result
  end

  def show
    result = "Вопрос: #{@question.question_text}\nиз теста '#{@question.test.title}'"
    render plain: result
  end

  def new; end

  def create
    question = @test.questions.create(question_params)
    render plain: 'Создан новый вопрос'
  end

  def destroy
    @question.destroy!
    render plain: 'Вопрос удален'
  end

  private

  def find_test
    @test = Test.find(params[:test_id])
  end

  def find_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:question_text)
  end

  def rescue_with_question_not_found
    render plain: 'Вопрос не был найден'
  end
end
