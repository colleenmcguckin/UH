class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :load_user

  private

  def load_user
    if current_donor
      current_user = current_donor
      @user = Donor.find current_user
    elsif current_receiver
      current_user = current_receiver
      @user = Receiver.find current_user
    elsif current_admin
      current_user = current_admin
      @user = Admin.find current_user
    end
  end
end
