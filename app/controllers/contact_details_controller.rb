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
    if @contact_detail.update(demographic_params)
      redirect_to receiver_path(@user), notice: 'Demographic data successfully saved.'
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
      :receiver_id
    )
  end
end
