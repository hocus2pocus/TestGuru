class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create]

  def new
  end

  def create
    user = User.find_by(email: params[:email])


    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to cookies[:requested_path]? cookies[:requested_path] : tests_path

    else
      flash.now[:alert] = 'Are you a Guru? Verify your email and password please.'
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_path, alert: 'You are out now. Enter your email and password to continue.'
  end
end
