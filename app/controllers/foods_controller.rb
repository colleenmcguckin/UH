class FoodsController < ApplicationController

  before_action :load_user
  before_action :authenticate_user!
  before_action :only_donors_allowed, except: [:index, :show, :receive]

  def index
    if @user.donor?
      @foods = Food.where(donor_id: @user.id)
    elsif @user.receiver?
      @foods = Food.where(receiver_id: @user.id)
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
      redirect_to donor_food_path(@user, @food), notice: 'Donation has been updated'
    else
      render :edit
    end
  end

  def destroy
    load_food
    if @food.destroy!
      redirect_to donor_foods_path(@user), notice: 'Donation has been deleted.'
    else
      render :show, notice: "Donation couldn't be deleted."
    end
  end

  def show
    load_food
    if @user.donor?
      unless @user.id == @food.donor_id
        redirect_to donor_foods_path(@user), notice: 'You can only view your own foods.'
      end
    elsif @user.receiver?
      unless @user.id == @food.receiver_id
        redirect_to receiver_foods_path(@user), notice: 'You can only view your own foods.'
      end
    end
  end

  private

  def load_user
    if current_donor
      @user = Donor.find current_donor.id
    elsif current_receiver
      @user = Receiver.find current_receiver.id
    elsif current_admin
      @user = Admin.find current_admin.id
    end
  end

  def load_food
    @food = Food.find(params[:id])
  end

  def food_params
    params.require(:food).permit(
      :donor_id,
      :category_id,
      :name,
      :refrigerated,
      :keep_frozen,
      :shelf_stable,
      :prepared_meal,
      :description
    )
  end

  def only_donors_allowed
    if @user.receiver?
      redirect_to receiver_path @user, notice: 'You must be a donor to do this.'
    end
  end
end
