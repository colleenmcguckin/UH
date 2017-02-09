class ReceiversController < ApplicationController

  before_action :authenticate_user!

  def index
    if @user.receiver?
      redirect_to receiver_path @user
    else
      @donation = Donation.find(params[:donation_id])
      if params[:search]
        @receivers = Receiver.unpaused.filter(@donation).near(params[:search][:zip], params[:search][:distance].to_i).order(:agency_name).page params[:page]
      else
        @receivers = Receiver.unpaused.filter(@donation).order(:agency_name).page params[:page]
      end
    end

  end

  def show
    if @user.donor?
      @receiver = Receiver.find(params[:id])
      if params[:donation_id]
        @donation = Donation.find(params[:donation_id])
      end
    elsif @user.receiver?
      unless @user.id.to_s == params[:id]
        redirect_to receiver_path @user
      end
    end
  end

  def update
    if @user.update receiver_params
      if receiver_params[:intake_survey_completed]
        redirect_to receiver_thank_you_path(@user), notice: 'Updates successfully saved.'
      else
        if @user.contact_details.any?
          redirect_to receiver_path(@user), notice: 'Updates successfully saved.'
        else
          redirect_to new_receiver_contact_detail_path @user, notice: 'Updates successfully saved.'
        end
      end
    else
      if @user.intake_survey_completed
        render :edit, notice: 'Updates could not be saved at this time, please try again.'
      else
        render 'receivers#details', notice: 'Updates could not be saved at this time, please try again.'
      end
    end
  end

  def details
  end

  def verify
  end

  def check_verification
    if @user.update(receiver_params) #&& @user.verify!
      # @user.verified_at = Time.current
      # if @user.save!
      redirect_to new_receiver_contact_detail_path(@user), notice: 'Tax ID Verified!'
      # end
    else
      redirect_to verify_receiver_path(@user), notice: 'Could not verify Tax ID. Please ensure all information is filled out, with only numbers are entered into the Tax ID box. If the problem persists, please contact support.'
    end
  end

  def pause
    if @user.pause!
      redirect_to receiver_donation_schedules_path(@user), notice: 'Availability successfully paused.'
    else
      render :index, notice: 'Availability could not be paused at this time. Please try again.'
    end
  end

  def unpause
    if @user.unpause!
      redirect_to receiver_donation_schedules_path(@user), notice: 'Availability successfully unpaused.'
    else
      render :index, notice: 'Availability could not be unpaused at this time. Please try again.'
    end
  end

  def confirm_intake
  end

  private

  def receiver_params
    params.require(:receiver).permit(
      :agency_name,
      :web_address,
      :street_address,
      :city,
      :state,
      :zip,
      :tax_id,
      :contact_name,
      :contact_phone,
      :contact_email,
      :dfr_contact_name,
      :dfr_contact_cell_phone,
      :dfr_contact_office_phone,
      :dfr_contact_email,
      :dfr_preferred_contact_method,
      :paused,
      :verified_at,
      :intake_survey_completed
    )
  end

end
