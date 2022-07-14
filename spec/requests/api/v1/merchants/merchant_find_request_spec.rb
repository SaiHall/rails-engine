require 'rails_helper'

RSpec.describe "E-Commerce API: Merchant Find" do
  it "Reaches an endpoint successfully" do
    create_list(:merchant, 5)
    Merchant.create!(name: "Turing")
    get "/api/v1/merchants/find?name=ring"

    expect(response).to be_successful
    expect(response.status).to eq(200)
  end

  it "Searches merchants for one based off name fragment, returns one, by alphabet" do
    create_list(:merchant, 5)
    Merchant.create!(name: "Turing")
    Merchant.create!(name: "Ring World")
    get "/api/v1/merchants/find?name=ring"

    response_body = JSON.parse(response.body, symbolize_names: true)
    merchant = response_body[:data]

    expect(merchant).to be_a(Hash)
    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant[:attributes][:name]).to be_a(String)
    expect(merchant[:attributes][:name]).to eq("Ring World")
    expect(merchant[:attributes][:name]).to_not eq("Turing")

    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to be_a(String)
  end

  it 'will return an empty data response if no match found' do
    get "/api/v1/merchants/find?name=ring"
    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(200)
    expect(response_body).to have_key(:data)
  end

  it 'will return an error without a parameter' do
    create_list(:merchant, 5)
    Merchant.create!(name: "Turing")
    Merchant.create!(name: "Ring World")
    get "/api/v1/merchants/find"

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
  end

  it 'will return an error if parameter is empty' do
    create_list(:merchant, 5)
    Merchant.create!(name: "Turing")
    Merchant.create!(name: "Ring World")
    get "/api/v1/merchants/find?name="

    expect(response).to_not be_successful
    expect(response.status).to eq(400)
  end
end
