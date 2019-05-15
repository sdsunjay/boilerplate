# app/controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    # TODO (Sunjay) Add additional param here
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def account_update_params
    # TODO (Sunjay) Add additional param here
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
  end
end
