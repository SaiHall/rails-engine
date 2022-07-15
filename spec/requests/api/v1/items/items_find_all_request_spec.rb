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

  it "Searches through items for prices that are above the query, and returns all that match" do
    merchant = Merchant.create!(name: "SomeStore SomeStuff")
    Item.create!(name: "Bubbles", description: "Soapy, shiny, bubbly bubbles", unit_price: 99.90, merchant_id: merchant.id)
    Item.create!(name: "Cheese", description: "Da cheddar", unit_price: 10.99, merchant_id: merchant.id)
    Item.create!(name: "Fabreeze", description: "Smells like sunshine", unit_price: 100.90, merchant_id: merchant.id)
    get "/api/v1/items/find_all?min_price=50"

    response_body = JSON.parse(response.body, symbolize_names: true)
    items = response_body[:data]

    expect(items).to be_a(Array)
    expect(items.count).to eq(2)
    items.each do |item|
      expect(item[:attributes][:name]).to_not eq("Cheese")
    end
  end

  it "Searches through items for prices that are below the query, and returns all that match" do
    merchant = Merchant.create!(name: "SomeStore SomeStuff")
    Item.create!(name: "Bubbles", description: "Soapy, shiny, bubbly bubbles", unit_price: 99.90, merchant_id: merchant.id)
    Item.create!(name: "Cheese", description: "Da cheddar", unit_price: 10.99, merchant_id: merchant.id)
    Item.create!(name: "Fabreeze", description: "Smells like sunshine", unit_price: 100.90, merchant_id: merchant.id)

    get "/api/v1/items/find_all?max_price=100"

    response_body = JSON.parse(response.body, symbolize_names: true)
    items = response_body[:data]

    expect(items).to be_a(Array)
    expect(items.count).to eq(2)
    items.each do |item|
      expect(item[:attributes][:name]).to_not eq("Fabreeze")
    end
  end

  it "Searches through items for prices that are within the range, and returns all that match" do
    merchant = Merchant.create!(name: "SomeStore SomeStuff")
    Item.create!(name: "Bubbles", description: "Soapy, shiny, bubbly bubbles", unit_price: 99.90, merchant_id: merchant.id)
    Item.create!(name: "Cheese", description: "Da cheddar", unit_price: 10.99, merchant_id: merchant.id)
    Item.create!(name: "Fabreeze", description: "Smells like sunshine", unit_price: 100.90, merchant_id: merchant.id)

    get "/api/v1/items/find_all?max_price=100&min_price=50"

    response_body = JSON.parse(response.body, symbolize_names: true)
    items = response_body[:data]

    expect(items).to be_a(Array)
    expect(items.count).to eq(1)
    items.each do |item|
      expect(item[:attributes][:name]).to_not eq("Fabreeze")
      expect(item[:attributes][:name]).to_not eq("Cheese")
    end
  end

  it "will return a correct error if invalid combinations are sent: all three" do
    get "/api/v1/items/find_all?max_price=100&min_price=50&name=womp"

    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response_body[:message]).to eq("Cannot send name with min and max price")
  end

  it "will return a correct error if invalid combinations are sent: min/name" do
    get "/api/v1/items/find_all?min_price=50&name=womp"

    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response_body[:message]).to eq("Cannot send name with min or max price")
  end

  it "will return a correct error if invalid combinations are sent: max/name" do
    get "/api/v1/items/find_all?max_price=50&name=womp"

    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response_body[:message]).to eq("Cannot send name with min or max price")
  end
end
