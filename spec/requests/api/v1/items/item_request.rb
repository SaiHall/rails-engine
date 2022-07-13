require 'rails_helper'

RSpec.describe "E-Commerce API: Item" do
  it 'sends one item' do
    create_list(:merchant, 1)

    item1 = Item.all.first
    item2 = Item.all.second
    item3 = Item.all.last

    get "/api/v1/items/#{item1.id}"

    expect(response).to be_successful
    expect(response.status).to eq(200)

    response_body = JSON.parse(response.body, symbolize_names: true)
    items = response_body[:data]
  end
end
