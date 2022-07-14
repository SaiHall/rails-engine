require 'rails_helper'

RSpec.describe "E-Commerce API: Items/Merchant" do
  it 'will return the merchant from an item' do
    create_list(:merchant, 3)

    merchant = Merchant.all.second
    item = Item.all.third

    get "api/v1/items/#{item.id}/merchant"

    expect(response).to be_successful
    expect(response.status).to eq(200)
  end
end
