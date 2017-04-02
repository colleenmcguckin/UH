class DonationSchedulesController < ApplicationController

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
    @donation_schedule = @donation_schedules.find params[:id]
  end

  def update
    @receiver = Receiver.find params[:receiver_id]

    @donation_schedule = @receiver.donation_schedules.find params[:id]
    if @donation_schedule.update donation_schedule_params
      redirect_to receiver_donation_schedules_path @receiver
    else
      render :new, notice: 'Schedule could not be saved. Please try again'
    end
  end

  def destroy
  end

  private

  def load_donation_schedules
    @receiver = Receiver.find params[:receiver_id]
    @donation_schedules = @receiver.donation_schedules.order(:day_of_week)
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
