class TestsController < ApplicationController
  def index
    # respond_to do |format|
    #   format.html { render html: '<h1>All tests</h1>'.html_safe }
    #   format.json { render json: {tests: Test.all}}
    # end

    # logger.info(self.object_id)

    # byebug
    # render inline: '<%= console %>'

    # result = ["Class: #{params.class},", "Parametrs: #{params.inspect}"]
    # render plain: result.join("\n")

    @tests = Test.all
  end

  def show
    @test = Test.find(params[:id])
  end

  def search
    result = ["Class: #{params.class},", "Parametrs: #{params.inspect}"]
    render plain: result.join("\n")
  end

  def new
    @test = Test.new
  end

  def edit
    @test = Test.find(params[:id])
  end

  def create
    # result = ["Class: #{params.class},", "Parametrs: #{params.inspect}"]
    # render plain: result.join("\n")
    # byebug
    @test = Test.new(test_params)

    if @test.save
      redirect_to @test
    else
      render :new
    end

    # render plain: test.inspect
  end

  def update
      @test = Test.find(params[:id])

    if @test.update(test_params)
      redirect_to @test
    else
      render :edit
    end
  end

  private

  def test_params
    params.require(:test).permit(:title, :level, :author_id, :category_id)
  end
end
