class DonationItemsController < ApplicationController
  before_action :load_donation
  before_action :load_user

  def index
    @donation_items = DonationItem.where donation_id: params[:donation_id]
  end

  def new
    @donation_item = DonationItem.new(donation_id: @donation.id)
  end

  def create
    load_user
    load_donation

    @donation_item = Donation.find(@donation.id).items.new donation_item_params
    if @donation_item.save
      redirect_to user_donation_path(@user, @donation), notice: 'Donation Item has been added'
    else
      render :new
    end
  end

  private

  def load_donation
    @donation = Donation.find params[:donation_id]
  end

  def load_user
    @user = User.find params[:user_id]
  end

  def donation_item_params
    params.require(:donation_item).permit(
      :description,
      :quantity,
      :quantity_type
    )
  end
end
