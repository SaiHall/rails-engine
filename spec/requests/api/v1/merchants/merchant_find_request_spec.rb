require 'rails_helper'

RSpec.describe "E-Commerce API: Merchant Find" do
  it "Reaches an endpoint successfully" do
    create_list(:merchant, 5)
    get "/api/v1/merchants/find?name=ring"

    expect(response).to be_successful
    expect(response.status).to eq(200)

    response_body = JSON.parse(response.body, symbolize_names: true)
    merchant = response_body[:data]
  end

  xit "Searches merchants for one based off params" do
    create_list(:merchant, 5)
    get "/api/v1/merchants/find?name=ring"
  end
end
