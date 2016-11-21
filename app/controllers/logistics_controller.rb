class LogisticsController < ApplicationController
  before_action :load_receiver
  before_action :load_logistic, except: [:index, :new, :create]

  def index
  end

  def show
  end

  def new
    @logistic = Logistic.new(receiver_id: @user.id)
  end

  def create
    @logistic = Logistic.new(receiver_id: @user.id)
    if @logistic.update(logistic_params)
      redirect_to new_receiver_restriction_path(@user), notice: 'Logistic info successfully saved.'
    else
      render :new, notice: 'Could not save logistic info at this time. Please try again.'
    end
  end

  def edit
  end

  def update
    @logistic = @user.logistics.first || Restriction.new(receiver_id: @user.id)
    if @logistic.update(logistic_params)
      redirect_to receiver_logistic_path(@user, @logistic), notice: 'Logistic info successfully updated.'
    else
      render :new, notice: 'Could not save logistic info at this time. Please try again.'
    end
  end

  def destroy
  end

  private

  def load_logistic
    @logistic = Logistic.find params[:id]
  end

  def load_receiver
    @user = Receiver.find params[:receiver_id]
  end

  def logistic_params
    params.require(:logistic).permit(
      :receiver_id,
      :transportation_available,
      :driver_status,
      :insurance_status,
      :vehicle_style,
      :freezer_type,
      :refrigerator_type,
      :indoor_dry_storage,
      :safe_handling_program,
      :meal_usage,
      :meal_distribution_frequency,
      contribution_ids: []
    )
  end
end
