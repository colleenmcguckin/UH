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
      @user = Donor.find current_donor
    elsif current_receiver
      @user = Receiver.find current_receiver
    elsif current_admin
      @user = Admin.find current_admin
    end
  end

end
