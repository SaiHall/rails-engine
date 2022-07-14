require 'rails_helper'

RSpec.describe "E-Commerce API: Items/Merchant" do
  it 'will return the merchant from an item' do
    create_list(:merchant, 3)

    merchant = Merchant.all.second
    item = merchant.items.first

    get "/api/v1/items/#{item.id}/merchant"

    expect(response).to be_successful
    expect(response.status).to eq(200)
  end

  it 'will return the correct merchant' do
    create_list(:merchant, 3)

    merchant1 = Merchant.all.second
    item = merchant1.items.first

    get "/api/v1/items/#{item.id}/merchant"

    response_body = JSON.parse(response.body, symbolize_names: true)
    merchant = response_body[:data]

    expect(merchant).to be_a(Hash)
    expect(merchant[:attributes][:name]).to eq(merchant1.name)
    expect(merchant[:id]).to eq("#{merchant1.id}")
  end

  it 'will return correct error for bad item id' do
    get "/api/v1/items/99999999/merchant"

    expect(response).to_not be_successful
    expect(response.status).to eq(404)
  end
end
