class Api::V1::Items::SearchController < ApplicationController

  def index
    items = Item.search_name(name_search_params) if params[:name]
    items = Item.search_min(price_search_params) if params[:min_price]
    items = Item.search_max(price_search_params) if params[:max_price]

    render json: ItemSerializer.format_items(items)
  end

  private
  def name_search_params
    params.require(:name)
  end

  def price_search_params
    if params[:min_price]
      params.require(:min_price)
    elsif params[:max_price]
      params.require(:max_price)
    end
  end
end
