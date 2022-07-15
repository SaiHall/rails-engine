class Api::V1::Items::SearchController < ApplicationController

  def index
    if params[:min_price] && params[:max_price] && params[:name]
      render json: { message: "Cannot send name with min and max price"}
    elsif (params[:min_price] || params[:max_price]) && params[:name]
      render json: { message: "Cannot send name with min or max price"}
    elsif params[:max_price] && params[:min_price]
      items = Item.search_min(params[:min_price])
      range = items.search_max(params[:max_price])
      render json: ItemSerializer.format_items(range)
    else
      items = Item.search_name(name_search_params) if params[:name]
      items = Item.search_min(params[:min_price]) if params[:min_price]
      items = Item.search_max(params[:max_price]) if params[:max_price]
      render json: ItemSerializer.format_items(items)
    end
  end

  private
  def name_search_params
    params.require(:name)
  end
end
