class DonationItemsController < ApplicationController

  before_action :authenticate_user!
  before_action :load_donation

  def index
    @donation_items = DonationItem.where donation_id: @donation.id
  end

  def new
    @donation_item = DonationItem.new(donation_id: @donation.id)
  end

  def create
    @donation_item = Donation.find(@donation.id).items.new donation_item_params
    if @donation_item.save
      redirect_to donor_donation_path(@user, @donation), notice: 'Donation item has been added.'
    else
      render :new
    end
  end

  def destroy
    @donation_item = DonationItem.find(params[:id])
    if @donation_item.destroy!
      redirect_to donor_donation_path(@user, @donation), notice: 'Item has been removed from donation.'
    else
      redirect_to donor_donation_path(@user, @donation), notice: 'Item could not be removed at this time.'
    end
  end

  private

  def load_donation
    @donation = Donation.find params[:donation_id]
  end

  def donation_item_params
    params.require(:donation_item).permit(
      :food_id,
      :quantity,
      :quantity_type
    )
  end
end
