class DonorsController < ApplicationController
  def index
  end

  def show
    @user = Donor.find(params[:id])
  end

  def edit
    load_user
  end

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
