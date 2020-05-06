class LotsController < ApplicationController
  # before_action :authenticate_user!
  # before_action :set_lot, only: %i[show edit uprate destroy]

  def index
    @lots = Lot.all
  end
end
