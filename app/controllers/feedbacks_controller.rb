class FeedbacksController < ApplicationController
  def new
  end

  def create
    FeedbacksMailer.send_feedback(params[:message], current_user.email).deliver_now
    redirect_to tests_path
    flash[:notice] = t('.message_sent')
  end
end
