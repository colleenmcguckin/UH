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
      @user = Donor.find current_donor
    elsif current_receiver
      @user = Receiver.find current_receiver
    elsif current_admin
      @user = Admin.find current_admin
    end
  end

end
