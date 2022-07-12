require 'rails_helper'

RSpec.describe "E-Commerce API: merchant/items" do
  it "sends the items from one merchant" do
    id1 = create(:merchant)

    get "/api/v1/merchants/#{id1.id}/items"

    expect(response).to be_successful
    expect(response.status).to eq(200)

    response_body = JSON.parse(response.body, symbolize_names: true)
    items = response_body[:data]

    expect(items).to be_a(Array)
    expect(items.count).to eq(4)

    items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)

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
  end
end
