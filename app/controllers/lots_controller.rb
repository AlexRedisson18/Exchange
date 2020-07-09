class LotsController < ApplicationController
  before_action :authenticate_user!, except: %i[show index]
  before_action :set_lot, only: %i[show edit update destroy]

  def index
    @lots = Lot.order('created_at DESC')
  end

  def show; end

  def new
    @lot = Lot.new
  end

  def create
    @lot = current_user.lots.new(lot_params)
    if @lot.save
      render json: @lot, status: :created, location: @profile
    else
      render json: @lot.errors, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @lot.update(lot_params)
      redirect_to lot_path(@lot)
    else
      render :edit
    end
  end

  def destroy
    @lot.destroy
    redirect_to profile_path
  end

  private

  def lot_params
    params.require(:lot).permit(
      :title,
      :description,
      :state,
      :price,
      :category_id,
      :image_cache,
      interesting_category_ids: [],
      images: []
    )
  end

  def set_lot
    @lot = Lot.find(params[:id])
  end
end
