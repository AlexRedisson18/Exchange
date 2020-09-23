class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @offer = Offer.find(message_params[:offer_id])
    if @offer.suggested_lot.user == current_user || @offer.requested_lot.user == current_user
      @message = current_user.messages.new(message_params)
      if @message.save
        if @offer.suggested_lot.user == current_user
          NotificationSendingService.new('new-message', @offer.suggested_lot, @offer.requested_lot).call
        elsif @offer.requested_lot.user == current_user
          NotificationSendingService.new('new-message', @offer.requested_lot, @offer.suggested_lot).call
        end
        render json: @message, status: :created
      else
        render json: @message.errors, status: 422
      end
    else
      head :forbidden
    end
  end

  private

  def message_params
    params.require(:message).permit(
      :body,
      :offer_id
    )
  end
end
