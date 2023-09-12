class PasswordResetsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user.present?
      # Send email
      # To setup mailer, enter this command: rails generate mailer Password reset
        # generate "mailer" generates a mailer, "Password" is name of mailer, and "reset" is an action to setup on the mailer controller
      PasswordMailer.with(user: @user).reset.deliver_now
    end
    redirect_to root_path, notice: "If an account with that email was found, we have sent a link to reset your password."
  end

  def edit
    @user = User.find_signed(params[:token], purpose: "password_reset")
  end
end