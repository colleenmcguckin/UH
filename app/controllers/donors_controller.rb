class DonorsController < ApplicationController
  def index
  end

  def show
    @user = Donor.find(params[:id])
  end

end
