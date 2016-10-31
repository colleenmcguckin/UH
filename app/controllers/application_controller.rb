class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :load_user

  private

  def load_user
    if current_donor
      @user = Donor.find current_donor
    elsif current_receiver
      @user = Receiver.find current_receiver
    elsif current_admin
      @user = Admin.find current_admin
    end
  end

  def authenticate_user!
    case @user
    when @user.receiver?
      authenticate_receiver!
    when @user.donor?
      authenticate_donor!
    when @user.receiver? && @user.donor?
      authenticate_admin!
    end
  end
end
