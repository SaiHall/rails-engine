require 'rails_helper'

RSpec.describe "E-Commerce API: Items" do
  it 'sends all items' do
    create_list(:items, 10)

    get "/api/v1/items"

    expect(response).to be_successful
    expect(response.status).to eq(200)
  end
end
