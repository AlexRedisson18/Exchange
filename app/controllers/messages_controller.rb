class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @offer = Offer.find(message_params[:offer_id])
    if @offer.suggested_lot.user == current_user || @offer.requested_lot.user == current_user
      @message = @offer.messages.new(message_params)
      if @message.save
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
      :user_id,
      :offer_id
    )
  end
end
