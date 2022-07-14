require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
    it {should validate_presence_of :unit_price}
    it {should validate_presence_of :merchant_id}
  end

  describe 'relationships' do
    it {should belong_to :merchant}
  end

  describe 'class methods' do
    it 'search returns array of similarly named items' do
      merchant = Merchant.create!(name: "SomeStore WithsumStuff")
      it1 = Item.create!(name: "Bubbles", description: "Soapy, shiny, bubbly bubbles", unit_price: 99.90, merchant_id: merchant.id)
      it2 = Item.create!(name: "Cheese", description: "Da cheddar", unit_price: 10.99, merchant_id: merchant.id)
      it3 = Item.create!(name: "Fabreeze", description: "Smells like sunshine", unit_price: 99.90, merchant_id: merchant.id)

      example = Item.search("ee")
      example2 = Item.search('eS')
      example3 = Item.search("Yd")

      expect(example).to eq([it2, it3])
      expect(example2).to eq([it1, it2])
      expect(example3).to eq([])
    end
  end
end
