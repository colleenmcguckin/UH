class FoodsController < ApplicationController

  before_action :authenticate_user!
  before_action :only_donors_allowed, except: [:index, :show, :receive]

  def index
    if @user.donor?
      if params[:archived] == 'true'
        @foods= Food.only_deleted.where(donor_id: @user.id)
      else
        @foods = Food.where(donor_id: @user.id)
      end
    elsif @user.admin?
      @foods = Food.all
    end
  end

  def new
    @food = Food.new(donor_id: @user.id)
  end

  def create
    @food = Food.new(donor_id: @user.id)
    if @food.update(food_params)
      redirect_to donor_foods_path(@user), notice: 'Food has been created'
    else
      render :new
    end
  end

  def edit
    load_food
  end

  def update
    load_food
    if @food.update food_params
      redirect_to donor_food_path(@user, @food), notice: 'Food has been updated'
    else
      render :edit
    end
  end

  def destroy
    load_food
    
    if @food.deleted?
      if @food.restore
        redirect_to donor_foods_path(@user), notice: 'Food has been restored.'
      else
        render :index, notice: "Food couldn't be restored. Please try again."
      end
    else
      if @food.destroy && @food.remove_from_pending_donations
        redirect_to donor_foods_path(@user), notice: 'Food has been archived.'
      else
        render :show, notice: "Food couldn't be archived. Please try again."
      end
    end
  end

  def show
    load_food
    if @user.donor?
      unless @user.id == @food.donor_id
        redirect_to donor_foods_path(@user), notice: 'You can only view your own foods.'
      end
    end
  end

  private

  def load_food
    @food = Food.with_deleted.find(params[:id])
  end

  def food_params
    params.require(:food).permit(
      :donor_id,
      :category_id,
      :name,
      :storage_temp,
      :prepared_meal,
      :description
    )
  end

  def only_donors_allowed
    unless @user.donor?
      redirect_to receiver_path @user, notice: 'You must be a donor to do this.'
    end
  end
end
