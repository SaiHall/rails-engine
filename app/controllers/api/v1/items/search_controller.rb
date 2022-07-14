class Api::V1::Items::SearchController < ApplicationController

  def index
    items = Item.search(search_params)
    render json: ItemSerializer.format_items(items)
  end

  private
  def search_params
    params.require(:name)
  end

end
