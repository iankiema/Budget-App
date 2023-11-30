# app/controllers/sessions_controller.rb
class SessionsController < Devise::SessionsController
  before_action :authenticate_user!, only: [:destroy]

  def destroy
    sign_out current_user
    redirect_to new_user_session_path, notice: 'Signed out successfully.'
  end
end
