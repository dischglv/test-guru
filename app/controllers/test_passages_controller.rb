class TestPassagesController < ApplicationController

  before_action :authenticate_user!
  before_action :find_test_passage, only: %i[show update result gist]
  before_action :set_badge_manager, only: :update

  def show; end

  def result; end

  def update
    @test_passage.accept!(params[:answer_ids])

    if @test_passage.completed?
      badge_manager = BadgeManager.new
      badges = badge_manager.award_badges(@test_passage)
      current_user.badges << badges
      
      TestsMailer.completed_test(@test_passage).deliver_now
      redirect_to result_test_passage_path(@test_passage)
    else
      render :show
    end
  end

  def gist
    service = GistQuestionService.new(@test_passage.current_question)
    result = service.call

    gist_id = result[:id]
    gist_url = result[:html_url]

    if service.success?
      gist = current_user.gists.create(gist_id: result[:id], 
                                      url: result[:html_url],
                                      question: @test_passage.current_question)

      flash[:notice] = t(".success_message", href: view_context.link_to('Ссылка на Gist', gist.url))
    else
      flash[:alert] = t('.failure')
    end

    redirect_to @test_passage
  end

  private

  def find_test_passage
    @test_passage = TestPassage.find(params[:id])
  end

  def set_badge_manager
    @badge_manager = BadgeManager.new
  end

end
