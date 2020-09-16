class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @offer = Offer.find(message_params[:offer_id])
    if @offer.suggested_lot.user == current_user || @offer.requested_lot.user == current_user
      @message = current_user.messages.new(message_params)
      if @message.save
        @suggested_lot = @offer.suggested_lot
        @requested_lot = @offer.requested_lot
        @requested_lot.user.notifications.create(kind: 'new-message',
                                                 lot_id: @suggested_lot.id,
                                                 my_lot_id: @requested_lot.id)
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
