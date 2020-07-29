class LotsController < ApplicationController
  before_action :authenticate_user!, except: %i[show index]
  before_action :set_lot, only: %i[edit update destroy publish unpublish]

  def index
    @categories = Category.all
    if params[:category_id].present?
      @lots = Lot.by_category(params[:category_id])
    else
      @lots = Lot.order('created_at DESC')
    end
    @active_category_id = params[:category_id]
  end

  def show
    @lot = Lot.find(params[:id])
  end

  def new
    @lot = Lot.new
  end

  def create
    @lot = current_user.lots.new(lot_params)
    if @lot.save
      render json: @lot, status: :created, location: @lot
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
