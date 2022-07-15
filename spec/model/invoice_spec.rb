require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it {should have_many :invoice_items}
    it {should have_many(:items).through(:invoice_items)}
  end
  describe 'destruction' do
    it 'should be destroyed when the last item on the invoice is destroyed' do
      merchant = Merchant.create!(name: "Jimbob Dudeguy")
      soap = Item.create!(name: "Soap", description: "Clean", unit_price: 10, merchant_id: merchant.id)
      invoice = Invoice.create!(status: "Yup")
      invoice.invoice_items.create!(item_id: soap.id, quantity: 1, unit_price: soap.unit_price)

      expect(Invoice.all).to eq([invoice])

      soap.destroy

      expect(Invoice.all).to eq([])
    end
  end
end
