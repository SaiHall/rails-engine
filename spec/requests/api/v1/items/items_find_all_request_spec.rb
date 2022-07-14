require 'rails_helper'

RSpec.describe "E-Commerce API: Items Find All" do
  it "Reaches an endpoint successfully" do
    create_list(:merchant, 5)
    merchant = Merchant.all.first
    Item.create!(name: "Bubbles", description: "Soapy, shiny, bubbly bubbles", unit_price: 99.90, merchant_id: merchant.id)
    Item.create!(name: "Cheese", description: "Da cheddar", unit_price: 10.99, merchant_id: merchant.id)
    Item.create!(name: "Fabreeze", description: "Smells like sunshine", unit_price: 99.90, merchant_id: merchant.id)
    get "/api/v1/items/find_all?name=ee"

    expect(response).to be_successful
    expect(response.status).to eq(200)
  end

  it "Searches through items for names that match, and returns all that match" do
    merchant = Merchant.create!(name: "SomeStore SomeStuff")
    Item.create!(name: "Bubbles", description: "Soapy, shiny, bubbly bubbles", unit_price: 99.90, merchant_id: merchant.id)
    Item.create!(name: "Cheese", description: "Da cheddar", unit_price: 10.99, merchant_id: merchant.id)
    Item.create!(name: "Fabreeze", description: "Smells like sunshine", unit_price: 99.90, merchant_id: merchant.id)
    get "/api/v1/items/find_all?name=ee"

    response_body = JSON.parse(response.body, symbolize_names: true)
    items = response_body[:data]

    expect(items).to be_a(Array)
    expect(items.count).to eq(2)

    items.each do |item|
      expect(item[:attributes][:name]).to_not eq("Bubbles")
    end
  end

  xit "Searches through items for prices that qualify, and returns all that match" do
  end
end
