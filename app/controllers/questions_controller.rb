class QuestionsController < ApplicationController
  before_action :find_test, only: %i[index new create]
  before_action :find_question, only: %i[show destroy edit update]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_question_not_found

  def index
  end

  def show
  end

  def new
    @question = Question.new
  end

  def create
    # question = @test.questions.create(question_params)
    # redirect_to test_path(@test), notice: 'Question was created.'

    @question = @test.questions.new(question_params)

    if @question.save
      redirect_to test_path(@test), notice: 'Question was created.'
    else
      render :new, notice: 'Question not created.'
    end
  end

  def edit
  end

  def update
    if @question.update(question_params)
      redirect_to @question.test, notice: 'Question updated.'
    else
      render :edit, notice: 'Question not updated.'
    end
  end

  def destroy
    question = @question.destroy
    #redirect_to test_questions_path(question.test.id)
    redirect_to test_path(question.test.id), notice: 'Question deleted.'
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
