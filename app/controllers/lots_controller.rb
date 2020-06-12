class LotsController < ApplicationController
  respond_to :html, :json
  before_action :authenticate_user!, except: %i[show index]
  before_action :set_lot, only: %i[show edit update]

  def index
    @lots = Lot.order('created_at DESC')
  end

  def show; end

  def new
    @lot = Lot.new
  end

  def create
    @lot = current_user.lots.new(lot_params)

    respond_to do |format|
      if @lot.save
        format.html { redirect_to @lot, notice: 'User was successfully created.' }
        format.js
        format.json { render json: @lot, status: :created, location: @lot }
      else
        format.html { render action: 'new' }
        format.json { render json: @lot.errors, status: :unprocessable_entity }
      end
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

  private

  def lot_params
    params.require(:lot).permit(
      :title,
      :description,
      :state,
      :price
    )
  end

  def set_lot
    @lot = Lot.find(params[:id])
  end
end
