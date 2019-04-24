class FeedbacksMailer < ApplicationMailer
  def send_feedback(feedback, email)
    @feedback = feedback
    @email = email
    @admin = Admin.first

    mail(to: @admin.email, subject: "New feedback from #{@email}")
  end
end
