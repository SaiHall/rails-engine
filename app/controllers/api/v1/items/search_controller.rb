class Api::V1::Items::SearchController < ApplicationController

  def index
    items = Item.search_name(name_search_params) if params[:name]
    items = Item.search_min(price_search_params) if params[:min_price]
    render json: ItemSerializer.format_items(items)
  end

  private
  def name_search_params
    params.require(:name)
  end

  def price_search_params
    params.require(:min_price)
  end

end
