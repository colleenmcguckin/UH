class ProgramsController < ApplicationController
  before_action :load_receiver
  before_action :load_program, except: [:index, :new, :create]

  def index
  end

  def show
  end

  def new
    @program = Program.new(receiver_id: @user.id)
  end

  def create
    @program = Program.new(receiver_id: @user.id)
    if @program.update(program_params)
      redirect_to new_receiver_demographic_path(@user), notice: 'Agency Info successfully saved.'
    else
      render :new, notice: 'Could not save Agency Info at this time. Please try again.'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def load_program
    @program = Program.find params[:id]
  end

  def load_receiver
    @user = Receiver.find params[:receiver_id]
  end

  def program_params
    params.require(:program).permit(
      :receiver_id,
      :perishable_food_distribution,
      :charge_for_service,
      :meal_style,
      :staff_size,
      :food_type_provided,
      dietary_restriction_ids: []
    )
  end
end
