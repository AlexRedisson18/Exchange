class OffersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_offer, only: %i[cancel unignore destroy]

  def create
    @offer = current_user.outgoing_offers.new(updated_params)
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

  def destroy
    @offer.destroy
    redirect_to profile_path
  end

  def cancel
    @offer.canceled!
  end

  def unignore
    @offer.pending!
  end

  private

  def set_offer
    @offer = Offer.find(params[:id])
  end

  def updated_params
    new_params = offer_params.to_h
    if new_params.include? :messages_attributes
      new_params[:messages_attributes]['0'].merge!(user_id: current_user.id)
      new_params
    else
      offer_params
    end
  end

  def offer_params
    params.require(:offer).permit(
      :suggested_lot_id,
      :requested_lot_id,
      messages_attributes: %i[body]
    )
  end
end
