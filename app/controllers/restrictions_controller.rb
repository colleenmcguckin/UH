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
    @restriction = @user.restrictions.first || Restriction.new(receiver_id: @user.id)
    if @restriction.update(restriction_params)
      redirect_to receiver_restriction_path(@user, @restriction), notice: 'Restrictions successfully saved. Set up your schedule now!'
    else
      render :new, notice: 'Could not save restriction info at this time. Please try again.'
    end
  end

  def edit
  end

  def update
    @restriction = @user.restrictions.first || Restriction.new(receiver_id: @user.id)
    if @restriction.update(restriction_params)
      redirect_to receiver_restriction_path(@user, @restriction), notice: 'Restrictions successfully updated.'
    else
      render :new, notice: 'Could not save restriction info at this time. Please try again.'
    end
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
