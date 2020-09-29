class LotsController < ApplicationController
  before_action :authenticate_user!, except: %i[index]
  before_action :set_lot, only: %i[edit update destroy publish unpublish]

  def index
    @categories = Category.all
    @search_word = params[:search]
    @active_category_id = params[:category_id]
    @lots = Lot.order('created_at DESC')
    @lots = @lots.search_by_title(@search_word) if @search_word.present?
    @lots = @lots.by_category(@active_category_id) if @active_category_id.present?
  end

  def show
    @offer = Offer.new
    @offer.messages.build
    @lot = Lot.find(params[:id])
    @profile_lots = current_user.lots.published
    @offers_i_made = current_user.outgoing_offers.where(requested_lot: @lot)
  end

  def new
    @lot = Lot.new
  end

  def create
    @lot = current_user.lots.new(lot_params)
    if @lot.save
      render json: @lot, status: :created
    else
      render json: @lot.errors, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @lot.update(lot_params)
      redirect_to lots_path
    else
      render :edit
    end
  end

  def destroy
    @lot.destroy
    redirect_to profile_path
  end

  def publish
    @lot.published!
  end

  def unpublish
    @lot.unpublished!
    @lot.incoming_offers.each do |offer|
      offer.canceled!
      NotificationSendingService.new('requested-lot-unpublished', offer.requested_lot, offer.suggested_lot).call
    end

    @lot.outgoing_offers.each do |offer|
      offer.canceled!
      NotificationSendingService.new('suggested-lot-unpublished', offer.suggested_lot, offer.requested_lot).call
    end
  end

  private

  def lot_params
    params.require(:lot).permit(
      :title,
      :description,
      :state,
      :price,
      :category_id,
      interesting_category_ids: [],
      images: []
    )
  end

  def set_lot
    @lot = current_user.lots.find(params[:id])
  end
end
