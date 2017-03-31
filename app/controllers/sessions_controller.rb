class SessionsController < Devise::SessionsController
  before_action :sign_out_current_user, only: [:new]

  def new
    super
  end

  def create
    super
  end

  private

  def sign_out_current_user
    if current_donor
      sign_out(current_donor)
      redirect_to new_receiver_session_path
    elsif current_receiver
      sign_out(current_receiver)
      redirect_to new_donor_session_path
    end
  end
end
