class TestsController < ApplicationController
  def index
    # respond_to do |format|
    #   format.html { render html: '<h1>All tests</h1>'.html_safe }
    #   format.json { render json: {tests: Test.all}}
    # end

    # logger.info(self.object_id)

    # byebug
    # render inline: '<%= console %>'

    result = ["Class: #{params.class},", "Parametrs: #{params.inspect}"]
    render plain: result.join("\n")
  end

  def show
    redirect_to 'http://rusrails.ru'
  end

  def search
    result = ["Class: #{params.class},", "Parametrs: #{params.inspect}"]
    render plain: result.join("\n")
  end

  def new
  end

  def create
    # result = ["Class: #{params.class},", "Parametrs: #{params.inspect}"]
    # render plain: result.join("\n")
    byebug
    test = Test.create(test_params)

    render plain: test.inspect
  end

  private

  def test_params
    params.require(:test).permit(:title, :level, :author_id, :category_id)
  end
end
