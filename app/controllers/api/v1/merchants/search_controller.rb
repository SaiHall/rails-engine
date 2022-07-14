class Api::V1::Merchants::SearchController < ApplicationController

  def show
    merchant = Merchant.search(search_params).first
    if merchant.nil?
      render json: MerchantSerializer.no_match
    else
      render json: MerchantSerializer.format_merchant(merchant)
    end
  end

  private
  def search_params
    params.require(:name)
  end
end
