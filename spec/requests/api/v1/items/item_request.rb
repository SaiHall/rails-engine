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
    expect(item[:attributes].keys).to eq([:name, :description, :unit_price, :merchant_id])

    expect(item[:attributes][:name]).to be_a(String)
    expect(item[:attributes][:description]).to be_a(String)
    expect(item[:attributes][:unit_price]).to be_a(Float)
    expect(item[:attributes][:merchant_id]).to be_an(Integer)
  end

  it 'returns error message if item id is invalid' do
    get "/api/v1/items/1"

    expect(response).to_not be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)
    expect(response_body).to have_key(:message)
  end

  it 'can delete an item' do
      create_list(:merchant, 1)

      item1 = Item.all.first
      merchant = Merchant.all.first

      expect(merchant.items.count).to eq(4)

      delete "/api/v1/items/#{item1.id}"

      expect(response).to be_successful
      expect(response.status).to eq(204)
      expect(merchant.items.count).to eq(3)
  end

  it 'can update an item' do
    create_list(:merchant, 1)
    item1 = Item.all.first

    item_params = ({
    "name": "Humidifier"
    })
    headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/items/#{item1.id}", headers: headers, params: JSON.generate(item: item_params)

      updated_item = Item.all.first

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(updated_item.name).to eq("Humidifier")
    expect(updated_item.description).to eq(item1.description)
  end

  it 'returns the record that was updated' do
    create_list(:merchant, 1)
    item1 = Item.all.first

    item_params = ({
    "unit_price": 50.00
    })
    headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/items/#{item1.id}", headers: headers, params: JSON.generate(item: item_params)

      response_body = JSON.parse(response.body, symbolize_names: true)
      item = response_body[:data]

      expect(item).to be_a(Hash)

      expect(item).to have_key(:id)
      expect(item).to have_key(:type)
      expect(item).to have_key(:attributes)
      expect(item[:attributes].keys).to eq([:name, :description, :unit_price, :merchant_id])
  end
end
