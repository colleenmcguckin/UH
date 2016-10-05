class ReceiversController < ApplicationController
  def index
    load_user
    @receivers = Receiver.all
    if @user.donor?
      @donation = Donation.find(params[:donation_id])
    end
  end

  def show
    load_user
    @receiver = Receiver.find(params[:id])
    if params[:donation_id]
      @donation = Donation.find(params[:donation_id])
    end
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
