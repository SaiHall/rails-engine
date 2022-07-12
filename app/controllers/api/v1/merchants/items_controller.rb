class Api::V1::Merchants::ItemsController < ApplicationController

  def index
    render json: ItemSerializer.items_from_merchant(Merchant.find(params[:merchant_id]))
  end

end
