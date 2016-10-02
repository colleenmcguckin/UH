class DonationsController < ApplicationController

  def index
    load_user
    if @user.donor?
      @donations = Donation.where(donor_id: @user.id)
    elsif @user.receiver?
      @donations = Donation.where(receiver_id: @user.id)
    end
  end

  def new
    load_user
    @donation = Donation.new(donor_id: @user.id)
  end

  def edit
    load_user
    load_donation
    @receivers = User.receiver
  end

  def create
    load_user

    @donation = Donation.new(donor_id: @user.id)
    if @donation.save
      redirect_to new_user_donation_item_path(@user, @donation), notice: 'Donation has been created'
    else
      render :new
    end
  end

  def update
    load_user
    load_donation
    if @donation.update donation_params
      redirect_to user_donation_path(@user, @donation), notice: 'Donation has been updated'
    else
      render :edit
    end
  end

  def destroy
    load_user
    load_donation
    if @donation.destroy!
      redirect_to user_donations_path(@user), notice: 'Donation has been deleted.'
    else
      render :show, notice: "Donation couldn't be deleted."
    end
  end

  def show
    load_user
    load_donation
  end

  private

  def load_user
    @user = User.find params[:user_id]
  end

  def load_donation
    @donation = Donation.find params[:id]
  end

  def donation_params
    params.require(:donation).permit(
      :donor_id,
      :receiver_id,
      :tracking_code,
      :confirmed_at,
      items: []
    )
  end
end
