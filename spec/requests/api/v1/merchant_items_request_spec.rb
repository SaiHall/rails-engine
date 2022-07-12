require 'rails_helper'

RSpec.describe "E-Commerce API: merchant/items" do
  it "sends the items from one merchant" do
    id1 = create(:merchant)

    get "/api/v1/merchants/#{id1.id}/items"

    expect(response).to be_successful
    expect(response.status).to eq(200)

    response_body = JSON.parse(response.body, symbolize_names: true)
  end
end
