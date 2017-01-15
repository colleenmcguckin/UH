class DonationsController < ApplicationController


  before_action :authenticate_user!
  before_action :only_donors_allowed, except: [:index, :show, :receive]

  def index
    if @user.donor?
      @donations = Donation.where(donor_id: @user.id).order(created_at: :desc)
    elsif @user.receiver?
      @donations = Donation.where(receiver_id: @user.id).where("donated_at IS NOT NULL").order(donated_at: :desc)
    elsif @user.admin?
      @donations = Donation.all
    end
  end

  def new
    @donation = Donation.new(donor_id: @user.id)
  end

  def create
    @donation = Donation.new(donor_id: @user.id)
    if @donation.save
      redirect_to donor_donation_path(@user, @donation), notice: 'Donation has been created'
    else
      render :new
    end
  end

  def edit
    load_donation
  end

  def update
    load_donation
    if @donation.update donation_params
      redirect_to donor_donation_path(@user, @donation), notice: 'Donation has been updated'
    else
      render :edit
    end
  end

  def destroy
    load_donation
    if @donation.destroy!
      redirect_to donor_donations_path(@user), notice: 'Donation has been deleted.'
    else
      render :show, notice: "Donation couldn't be deleted."
    end
  end

  def show
    load_donation
    if @user.donor?
      unless @user.id == @donation.donor_id
        redirect_to donor_donations_path(@user), notice: 'You can only view your own donations.'
      end
    elsif @user.receiver?
      unless @user.id == @donation.receiver_id
        redirect_to receiver_donations_path(@user), notice: 'You can only view your own donations.'
      end
    end
  end

  def add_receiver
    load_donation
    if @donation.update(receiver_id: params[:receiver_id])
      redirect_to donor_donation_path(@user, @donation), notice: 'Receiver has been added.'
    else
      render :show, notice: "Something went wrong, please try again. Receiver couldn't be added at this time."
    end
  end

  def donate
    load_donation
    if @donation.donate!
      ApplicationMailer.added_to_donation_mailer(@donation).deliver_now
      redirect_to donor_donation_path(@user, @donation), notice: 'Receiver has been notified. Write the tracking code on your donation and take it to them now, unless other transportation was arranged.'
    else
      render :show, notice: "Something went wrong, please try again. Receiver couldn't be confirmed at this time."
    end
  end

  def receive
    load_donation

    if @donation.receive!
      ApplicationMailer.donation_received_mailer(@donation).deliver_now
      redirect_to receiver_donations_path(@user, @donation), notice: 'Donation has been confirmed. Thank you!'
    else
      render :show, notice: "Something went wrong, please try again. Donation couldn't be confirmed at this time."
    end
  end

  private

  def load_donation
    @donation = Donation.find(params[:id])
  end

  def donation_params
    params.require(:donation).permit(
      :donor_id,
      :receiver_id,
      :tracking_code,
      :confirmed_at,
      :donated_at,
      :received_at,
      :total_meals,
      :total_value_cents,
      :total_value_dollars,
      :total_weight,
      items: []
    )
  end

  def only_donors_allowed
    if @user.receiver?
      redirect_to receiver_path @user, notice: 'You must be a donor to do this.'
    end
  end
end
