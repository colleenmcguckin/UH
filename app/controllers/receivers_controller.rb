class ReceiversController < ApplicationController

  before_action :authenticate_user!

  def index
    load_user
    @receivers = Receiver.all
    if @user.donor?
      @donation = Donation.find(params[:donation_id])
    end
  end

  def show
    load_user
    if @user.donor?
      @receiver = Receiver.find(params[:id])
      if params[:donation_id]
        @donation = Donation.find(params[:donation_id])
      end
    elsif @user.receiver?
      unless @user.id.to_s == params[:id]
        redirect_to receiver_path @user
      end
    end
  end

  def update
    load_user
    if @user.update receiver_params
      redirect_to receiver_path @user
    elsif
      render 'receivers#details'
    end
  end

  def details
    load_user
  end

  private

  def receiver_params
    params.require(:receiver).permit(
      :agency_name,
      :street_address,
      :city,
      :state,
      :zip,
      :tax_id
    )
  end

  def load_user
    if current_donor
      @user = Donor.find current_donor.id
    elsif current_receiver
      @user = Receiver.find current_receiver.id
    elsif current_admin
      @user = Admin.find current_admin.id
    end
  end

end
