class TestPassagesController < ApplicationController

  before_action :set_test_passage, only: %i[show update result gist]
  before_action :check_time_limit, only: :update

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

  def check_time_limit
    return unless @test_passage.test.time_limit?
    if Time.current >= @test_passage.time_finish
      @test_passage.stop_passage
      redirect_to tests_path
      flash[:alert] = t('.timeout')
    end
  end

  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end

  def achieve_badges
    return unless @test_passage.success?
    badges = BadgesControlService.new(@test_passage).call

    if badges.any?
      current_user.badges << badges
      badges.each do |badge|
        case badge.picture
        when "red-badge"
          flash[:red_badge] = t('.red-badge', reason: @test_passage.test.title)
        when "green-badge"
          flash[:green_badge] = t('.green-badge', reason: @test_passage.test.category.title)
        when "pink-badge"
          flash[:pink_badge] = t('.pink-badge', reason: @test_passage.test.level)
        else
          flash[:notice] = t('.other-badge')
        end
      end
    end
  end
end
