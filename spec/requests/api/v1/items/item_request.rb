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
    item = response_body[:data]

    expect(item).to be_a(Hash)

    expect(item).to have_key(:id)
    expect(item[:id]).to be_a(String)
    expect(item[:id]).to_not eq(item2.id)

    expect(item).to have_key(:type)
    expect(item[:type]).to be_a(String)

    expect(item).to have_key(:attributes)
    expect(item[:attributes]).to be_a(Hash)

    expect(item[:attributes]).to have_key(:name)
    expect(item[:attributes][:name]).to be_a(String)

    expect(item[:attributes]).to have_key(:description)
    expect(item[:attributes][:description]).to be_a(String)

    expect(item[:attributes]).to have_key(:unit_price)
    expect(item[:attributes][:unit_price]).to be_a(Float)


    expect(item[:attributes]).to have_key(:merchant_id)
    expect(item[:attributes][:merchant_id]).to be_an(Integer)
  end

  it 'returns error message if item id is invalid' do
    get "/api/v1/items/1"

    expect(response).to_not be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)
    expect(response_body).to have_key(:message)
  end

  it 'can create a new item' do
    create_list(:merchant, 1)

    merchant_id = Merchant.all.first.id

    item_params = ({
    "name": "Humidifier",
    "description": "From KFC",
    "unit_price": "50.00",
    "merchant_id": merchant_id
    })

    post "/api/v1/items/5", headers: headers, params: JSON.generate(item: item_params)

    response_body = JSON.parse(response.body, symbolize_names: true)
    item = response_body[:data]


  end
end
