class ReceiversController < ApplicationController
  def index
    @receivers = Receiver.all
  end

  def show
    @receiver = Receiver.find(params[:id])
  end


end
