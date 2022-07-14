require 'rails_helper'

RSpec.describe "E-Commerce API: Items" do
  it 'sends all items' do
    create_list(:merchant, 3)

    get "/api/v1/items"

    expect(response).to be_successful
    expect(response.status).to eq(200)

    response_body = JSON.parse(response.body, symbolize_names: true)
    items = response_body[:data]

    expect(items).to be_a(Array)
    expect(items.count).to eq(12)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)

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
  end

  it 'returns 404 error code if there are no items' do
    get "/api/v1/items"

    expect(response).to_not be_successful
    expect(response.status).to eq(404)
  end

  it 'can create a new item' do
    create_list(:merchant, 1)

    merchant_id = Merchant.all.first.id

    item_params = ({
    "name": "Humidifier",
    "description": "From KFC",
    "unit_price": 50.00,
    "merchant_id": merchant_id
    })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)

    expect(response).to be_successful
    expect(response.status).to eq(201)

    response_body = JSON.parse(response.body, symbolize_names: true)
    item = response_body[:data]

    created_item = Item.last

    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price])
    expect(created_item.merchant_id).to eq(item_params[:merchant_id])
    expect(item[:attributes][:name]).to eq(item_params[:name])
    expect(item[:attributes][:description]).to eq(item_params[:description])
    expect(item[:attributes][:unit_price]).to eq(item_params[:unit_price])
    expect(item[:attributes][:merchant_id]).to eq(item_params[:merchant_id])
  end

  it 'create: will exclude attributes that are not required' do
    create_list(:merchant, 1)

    merchant_id = Merchant.all.first.id

    item_params = ({
    "name": "Humidifier",
    "description": "From KFC",
    "color": "blue",
    "unit_price": 50.00,
    "merchant_id": merchant_id
    })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)

    created_item = Item.last

    expect(created_item.attributes).to_not have_key([:color])
  end

  it 'create: will show the correct error if information is missing' do
    create_list(:merchant, 1)

    merchant_id = Merchant.all.first.id

    item_params = ({
    "name": "Humidifier",
    "description": "From KFC",
    "merchant_id": merchant_id
    })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)

    expect(response).to_not be_successful
    expect(response.status).to eq(422)
  end
end
