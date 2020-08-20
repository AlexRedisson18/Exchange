class OffersController < ApplicationController
  before_action :authenticate_user!

  def create
    @lot = Lot.find(params[:requested_lot_id])
    @offer = @lot.incoming_offers.new(suggested_lot_id: params[:suggested_lot_id])
    if @offer.save
      render json: @offer, status: :created, location: @offer
    else
      render json: @offer.errors
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
