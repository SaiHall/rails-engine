require 'rails_helper'

RSpec.describe "E-Commerce API: Merchant" do
  it "sends details of one merchant" do
    id1 = create(:merchant)
    id2 = create(:merchant)

    get "/api/v1/merchants/#{id1.id}"

    expect(response).to be_successful
    expect(response.status).to eq(200)

    response_body = JSON.parse(response.body, symbolize_names: true)
    merchant = response_body[:data]

    expect(merchant).to be_a(Hash)
    expect(merchant[:attributes]).to have_key(:name)
    expect(merchant[:attributes][:name]).to be_a(String)

    expect(merchant).to have_key(:id)
    expect(merchant[:id]).to be_a(String)
    expect(merchant[:id]).to eq("#{id1.id}")
    expect(merchant[:id]).to_not eq("#{id2.id}")

    expect(merchant[:attributes]).to_not have_key(:created_at)
  end

  it 'returns error message if merchant id is invalid' do
    get "/api/v1/merchants/1"

    expect(response).to_not be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)
    expect(response_body).to have_key(:message)
  end
end
