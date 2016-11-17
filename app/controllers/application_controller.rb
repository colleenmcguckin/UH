class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :load_user
  before_action :load_new_donation
  before_action :load_restriction_to_edit

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

  def after_sign_in_path_for resource
    if resource.is_a?(Donor)
      donor_path resource
    elsif resource.is_a?(Receiver)
      receiver_path resource
    else
      super
    end
  end

  def load_new_donation
    @new_donation = Donation.new
  end

  def load_restriction_to_edit
    @restricion_to_edit = @user.restrictions.first || @user.restrictions.create
  end
end
