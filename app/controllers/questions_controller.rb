class QuestionsController < ApplicationController
  before_action :find_test, only: %i[index create]
  before_action :find_question, only: %i[show destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_question_not_found

  def index
    # render json: { questions: @test.questions }
  end

  def show
    render json: { body: @question.body }
  end

  def new
  end

  def create
    question = @test.questions.create(question_params)
    respond_to do |format|
      format.html { redirect_to test_questions_path, notice: 'Question was created.' }
    end
    # render plain: question.inspect
  end

  def destroy
    question = @question.destroy
    # respond_to do |format|
    #   format.html { redirect_to test_questions_url, notice: 'Question was deleted.'}
    # end
    redirect_to test_questions_path(question.test.id)
  end

  private

  def find_test
    @test = Test.find(params[:test_id])
  end

  def find_question
    @question = Question.find(params[:id])
  end

  def rescue_question_not_found
    render plain: 'Question not found.'
  end

  def question_params
    params.require(:question).permit(:body)
  end
end
