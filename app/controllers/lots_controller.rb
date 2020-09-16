class LotsController < ApplicationController
  before_action :authenticate_user!, except: %i[index]
  before_action :set_lot, only: %i[edit update destroy publish unpublish]

  def index
    @categories = Category.all
    @active_category_id = params[:category_id]
    @lots = if @active_category_id.present?
              Lot.by_category(@active_category_id)
            else
              Lot.order('created_at DESC')
            end
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
      @suggested_lot = offer.suggested_lot
      @requested_lot = offer.requested_lot
      @suggested_lot.user.notifications.create(kind: 'requested-lot-unpublished',
                                               lot_id: @requested_lot.id,
                                               my_lot_id: @suggested_lot.id)
    end
    @lot.outgoing_offers.each do |offer|
      offer.canceled!
      @suggested_lot = offer.suggested_lot
      @requested_lot = offer.requested_lot
      @requested_lot.user.notifications.create(kind: 'suggested-lot-unpublished',
                                               lot_id: @suggested_lot.id,
                                               my_lot_id: @requested_lot.id)
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
