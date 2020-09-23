class OffersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_offer, only: %i[cancel unignore destroy]

  def create
    @offer = current_user.outgoing_offers.new(updated_params)
    if @offer.valid?
      suggested_lot = Lot.find(offer_params[:suggested_lot_id])
      requested_lot = @offer.requested_lot
      if current_user == suggested_lot.user
        @offer.save!
        NotificationSendingService.new('new-offer', suggested_lot, requested_lot).call
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
  end

  def cancel
    @offer.canceled!
    suggested_lot = @offer.suggested_lot
    requested_lot = @offer.requested_lot
    if @offer.suggested_lot.user == current_user
      NotificationSendingService.new('sender-cancel-offer', suggested_lot, requested_lot).call
    elsif @offer.requested_lot.user == current_user
      NotificationSendingService.new('recipient-cancel-offer', requested_lot, suggested_lot).call
    end
  end

  def unignore
    @offer.pending!
  end

  private

  def set_offer
    @offer = current_user.outgoing_offers.find_by(id: params[:id])
    @offer = current_user.incoming_offers.find_by!(id: params[:id]) if @offer.blank?
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
