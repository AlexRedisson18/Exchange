class OffersController < ApplicationController
  before_action :authenticate_user!

  def create
    @offer = Offer.new(offer_params)
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
