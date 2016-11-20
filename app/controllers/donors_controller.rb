class DonorsController < ApplicationController

  before_action :authenticate_user!

  def index
  end

  def show
    unless @user.id.to_s == params[:id]
      redirect_to donor_path @user
    end
  end

  def edit
  end

  def details
  end

end
