class DonationSchedulesController < ApplicationController

  before_action :load_user
  before_action :authenticate_user!

  def index
    load_donation_schedules
  end

  def new
    @donation_schedule = DonationSchedule.new(receiver_id: @user.id)
  end

  def create
    @donation_schedule = Receiver.find(@user.id).donation_schedules.new donation_schedule_params
    if @donation_schedule.save
      redirect_to receiver_donation_schedules_path @user
    else
      render :new, notice: 'Schedule could not be saved. Please try again'
    end
  end

  def edit
    load_donation_schedules
    @donation_schedule = @user.donation_schedules.find params[:id]
  end

  def update
    @donation_schedule = @user.donation_schedules.find params[:id]
    if @donation_schedule.update donation_schedule_params
      redirect_to receiver_donation_schedules_path @user
    else
      render :new, notice: 'Schedule could not be saved. Please try again'
    end
  end

  def destroy
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

  def load_donation_schedules
    @donation_schedules = @user.donation_schedules.order(:day_of_week)
  end

  def donation_schedule_params
    params.require(:donation_schedule).permit(
      :day_of_week,
      :open_at_hour,
      :open_at_minute,
      :close_at_hour,
      :close_at_minute
    )
  end
end
