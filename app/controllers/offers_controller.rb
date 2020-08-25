class OffersController < ApplicationController
  before_action :authenticate_user!

  def create
    @suggested_lot = Lot.find(offer_params[:suggested_lot_id])
    if @suggested_lot.user == current_user
      @offer = Offer.new(offer_params)
      if @offer.save
        render json: @offer, status: :created
      else
        render json: @offer.errors
      end
    else
      head :forbidden
    end
  end

  private

  def offer_params
    params.require(:offer).permit(
      :suggested_lot_id,
      :requested_lot_id
    )
  end
end
