class TestPassagesController < ApplicationController

  before_action :set_test_passage, only: %i[show update result gist]

  def show
  end

  def result
  end

  def update
    @test_passage.accept!(params[:answer_ids])

    if @test_passage.completed?
      TestsMailer.completed_test(@test_passage).deliver_now
      achieve_badges
      redirect_to result_test_passage_path(@test_passage)
    else
      render :show
    end
  end

  def gist
    result = GistQuestionService.new(@test_passage.current_question).call

    if result.success?
      current_user.gists.create!(question: @test_passage.current_question,
                                url: result.gist_url)
      flash[:notice] = t('.success', url: result.gist_url)
    else
      flash[:alert] = t('.failure')
    end

    redirect_to @test_passage
  end

  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end

  def achieve_badges
    badges = BadgesControlService.new(@test_passage).call

    if badges.any?
      current_user.badges << badges
    end
  end
end
