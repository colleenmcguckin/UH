class ReceiversController < ApplicationController

  before_action :authenticate_user!
  before_action :load_receiver, except: [:index, :show]

  def index
    if @user.receiver?
      redirect_to receiver_path @user
    else
      @donation = Donation.find(params[:donation_id])
      if params[:search]
        @receivers = Receiver.unpaused.filter(@donation).near(params[:search][:zip], params[:search][:distance].to_i).order(:agency_name).page params[:page]
      else
        @receivers = []
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
    if @receiver.update receiver_params
      if receiver_params[:intake_survey_completed]
        redirect_to receiver_thank_you_path(@receiver), notice: 'Updates successfully saved.'
      else
        if @receiver.contact_details.any?
          redirect_to receiver_path(@receiver), notice: 'Updates successfully saved.'
        else
          redirect_to new_receiver_contact_detail_path @receiver, notice: 'Updates successfully saved.'
        end
      end
    else
      binding.pry
      if @receiver.intake_survey_completed || @user.admin?
        redirect_to @receiver, notice: 'Updates could not be saved at this time, please try again.'
      else
        redirect_to @receiver, notice: 'Updates could not be saved at this time, please try again.'
      end
    end
  end

  def details
  end

  def verify
  end

  def check_verification
    if @receiver.update(receiver_params) && @receiver.verify!
      @receiver.verified_at = Time.current
      if @receiver.save!
        redirect_to new_receiver_contact_detail_path(@receiver), notice: 'Tax ID Verified!'
      end
    else
      redirect_to verify_receiver_path(@receiver), notice: 'Could not verify Tax ID. Please ensure all information is filled out, with only numbers are entered into the Tax ID box. If the problem persists, please contact support.'
    end
  end

  def pause
    if @receiver.pause!
      redirect_to receiver_donation_schedules_path(@receiver), notice: 'Availability successfully paused.'
    else
      render :index, notice: 'Availability could not be paused at this time. Please try again.'
    end
  end

  def unpause
    if @receiver.unpause!
      redirect_to receiver_donation_schedules_path(@receiver), notice: 'Availability successfully unpaused.'
    else
      render :index, notice: 'Availability could not be unpaused at this time. Please try again.'
    end
  end

  def confirm_intake
  end

  private
  def load_receiver
    if @user.admin? || @user.receiver?
      @receiver = Receiver.find params[:id]
    else
      @receiver = Receiver.find params[:receiver_id]
    end
  end
  def receiver_params
    params.require(:receiver).permit(
      :agency_name,
      :web_url,
      :email,
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
