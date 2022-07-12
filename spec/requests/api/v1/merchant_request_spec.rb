require 'rails_helper'

RSpec.describe "E-Commerce API" do
  it "sends details of one merchant" do
    create_list(:merchant, 2)

    id = Merchant.all.first.id

    get "/api/v1/merchants/#{id}"

    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)
    merchant = response_body[:data]

    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant[:attributes][:name]).to be_a(String)

    expect(merchant[:attributes]).to have_key(:id)
    expect(merchant[:attributes][:id]).to be_an(Integer)

    expect(merchant[:attributes]).to_not have_key(:created_at)
  end
end
