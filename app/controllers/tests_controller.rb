class TestsController < ApplicationController

  before_action :find_test, only: %i[start]

  def index
    @tests = Test.all
  end

  def start
    if @test.questions.count > 0
      current_user.tests.push(@test)
      redirect_to current_user.test_passage(@test)
    else
      redirect_to tests_path
      flash[:notice] = t('.error')
    end
  end

  private

  def find_test
    @test = Test.find(params[:id])
  end
end
