class LotsController < ApplicationController
  def index
    @lots = Lot.all
  end
end
