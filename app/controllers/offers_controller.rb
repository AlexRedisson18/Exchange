
class OffersController < ApplicationController
  before_action :authenticate_user!

  def create
    @offer = current_user.outgoing_offers.new(offer_params)
    if @offer.valid?
      @suggested_lot = Lot.find(offer_params[:suggested_lot_id])
      if current_user == @suggested_lot.user
        @offer.save!
        render json: @offer, status: :created
      else
        head :forbidden
      end
    else
      render json: @offer.errors, status: 422
    end
  end

  private

  def offer_params
    params.require(:offer).permit(
      :suggested_lot_id,
      :requested_lot_id,
      messages_attributes: %i[body user_id]
    )
  end
end
