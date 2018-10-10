class TestsController < ApplicationController
  def index
    respond_to do |format|
      format.html { render html: '<h1>All tests</h1>'.html_safe }
      format.json { render json: {tests: Test.all}}
    end

    logger.info(self.object_id)

    # byebug
    # render inline: '<%= console %>'
  end

  def show
    redirect_to 'http://rusrails.ru'
  end
end
