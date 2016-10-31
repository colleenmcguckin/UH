class DonorsController < ApplicationController

  before_action :authenticate_user!

  def index
  end

  def show
    load_user
    unless @user.id.to_s == params[:id]
      redirect_to donor_path @user
    end
  end

  def edit
    load_user
  end

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

end
