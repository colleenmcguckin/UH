class ContactDetailsController < ApplicationController
  before_action :load_receiver
  before_action :load_contact_detail, except: [:index, :new, :create]


  def index
  end

  def show
  end

  def new
    @contact_detail = ContactDetail.new(receiver_id: @user.id)
  end

  def create
    @contact_detail = ContactDetail.new(receiver_id: @user.id)
    if @contact_detail.update(contact_detail_params)
      redirect_to new_receiver_program_path(@user), notice: 'Contact details successfully saved.'
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def load_contact_detail
    @contact_detail = ContactDetail.find params[:id]
  end

  def load_receiver
    @user = Receiver.find params[:receiver_id]
  end

  def contact_detail_params
    params.require(:contact_detail).permit(
      :receiver_id,
      :contact_name,
      :contact_email,
      :contact_phone,
      :dfr_contact_name,
      :dfr_contact_email,
      :dfr_contact_office_phone,
      :dfr_contact_cell_phone,
      :dfr_preffered_contact_method
    )
  end
end
