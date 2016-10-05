class DonationsController < ApplicationController

  def index
    load_user
    @donations = Donation.where(donor_id: @user.id)
  end

  def new
    load_user
    @donation = Donation.new(donor_id: @user.id)
  end

  def edit
    load_user
    load_donation
  end

  def create
    load_user

    @donation = Donation.new(donor_id: @user.id)
    if @donation.save
      redirect_to donor_donation_path(@user, @donation), notice: 'Donation has been created'
    else
      render :new
    end
  end

  def update
    load_user
    load_donation
    if @donation.update donation_params
      redirect_to donor_donation_path(@user, @donation), notice: 'Donation has been updated'
    else
      render :edit
    end
  end

  def destroy
    load_user
    load_donation
    if @donation.destroy!
      redirect_to donor_donations_path(@user), notice: 'Donation has been deleted.'
    else
      render :show, notice: "Donation couldn't be deleted."
    end
  end

  def show
    load_user
    load_donation
  end

  def add_receiver
    load_user
    load_donation
    @donation.update(receiver_id: params[:receiver_id])
    if @donation.save
      redirect_to donor_donations_path(@user), notice: 'Receiver has been added.'
    else
      render :show, notice: "Something went wrong, please try again. Receiver couldn't be added."
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

  def load_donation
    @donation = Donation.find params[:id]
  end

  def donation_params
    {}
  end
end
