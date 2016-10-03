class UsersController < ApplicationController
  before_action :load_user, except: [:index]
  def index
    @donors = User.donor
    @receivers = User.receiver
  end

  def show
    if @user.donor?
      @donations = Donation.where(donor_id: @user.id)
    elsif @user.receiver?
      @donations = Donation.where(receiver_id: @user.id)
    end
  end

  def edit
  end

  def update
    if @user.update user_params
      redirect_to @user, notice: 'User has been updated.'
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy!
      redirect_to users_path, notice: 'User has been deleted.'
    else
      render :show, notice: "User couldn't be deleted."
    end
  end

  private

  def load_user
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit(
      :role,
      :first_name,
      :last_name,
      :organization_name
    )
  end
end
