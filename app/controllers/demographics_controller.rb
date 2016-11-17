class DemographicsController < ApplicationController
  before_action :load_demographic, except: [:index, :new, :create]
  before_action :load_receiver

  def index
  end

  def show
  end

  def new
    @demographic = Demographic.new(receiver_id: @user.id)
  end

  def create
    @demographic = Demographic.new(receiver_id: @user.id)
    if @demographic.update(demographic_params)
      redirect_to new_receiver_logistic_path(@user), notice: 'Demographic data successfully saved.'
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def load_demographic
    @demographic = Demographic.find params[:id]
  end

  def load_receiver
    @user = Receiver.find params[:receiver_id]
  end

  def demographic_params
    params.require(:demographic).permit(
      :percent_male,
      :percent_female,
      :percent_other_gender,
      :percent_youth,
      :percent_adult,
      :percent_senior,
      :percent_american_native,
      :percent_african_american,
      :percent_asian,
      :percent_hispanic,
      :percent_pacific_islander,
      :percent_white,
      :percent_portuguese,
      :percent_single_no_kids,
      :percent_single_with_kids,
      :percentage_married_no_kids,
      :percentage_married_with_kids,
      :precent_employed,
      :percent_unemployed,
      :percent_veteran_military,
      :percent_active_military,
      :percentage_with_dietary_restrictions,
      :total_guests_served_per_week,
      :meals_served_per_breakfast,
      :meals_served_per_lunch,
      :meals_served_per_dinner,
      :total_receiving_groceries,
      :mode_of_transportation,
      :distance_traveled,
      :receiver_id
    )
  end
end
