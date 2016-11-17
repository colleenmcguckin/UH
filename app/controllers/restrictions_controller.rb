class RestrictionsController < ApplicationController
  before_action :load_receiver
  before_action :load_restriction, except: [:index, :new, :create]

  def index
  end

  def show
  end

  def new
    @restriction = Restriction.new(receiver_id: @user.id)
  end

  def create
    @restriction = Restriction.new(receiver_id: @user.id)
    if @restriction.update(restriction_params)
      redirect_to receiver_path(@user), notice: 'Restriction info successfully saved.'
    else
      render :new, notice: 'Could not save restriction info at this time. Please try again.'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def load_restriction
    @restriction = Restriction.find params[:id]
  end

  def load_receiver
    @user = Receiver.find params[:receiver_id]
  end

  def restriction_params
    params.require(:restriction).permit(
      :receiver_id,
      category_ids: [],
      storage_temp_ids: []
    )
  end
end
