require 'rails_helper'

RSpec.describe "E-Commerce API: Merchant Find" do
  it "Reaches an endpoint successfully" do
    create_list(:merchant, 5)
    get "/api/vi/merchants/find?=ring"

    expect(response).to be_successful
    expect(response.status).to eq(200)
  end

  xit "Searches merchants for one based off params" do
    create_list(:merchant, 5)
    get "/api/vi/merchants/find?=ring"
  end
end
