class DonorsController < ApplicationController

  before_action :authenticate_user!

  def index
  end

  def show
    unless @user.id.to_s == params[:id]
      redirect_to donor_path @user
    end
    @donations = @user.donations
  end

  def update
    if @user.update donor_params
      redirect_to donor_path(@user), notice: 'Details successfully updated.'
    else
      render :edit, notice: 'Details could not be saved at this time, please try again.'
    end
  end

  def edit
  end

  def details
  end

  private

  def donor_params
    params.require(:donor).permit(
      :agency_name,
      :street_address,
      :city,
      :state,
      :zip,
      :tax_id,
      :contact_name,
      :contact_phone,
      :contact_email
    )
  end

end
