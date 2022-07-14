require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'validations' do
    it {should validate_presence_of :name}
  end

  describe 'relationships' do
    it {should have_many :items}
  end

  describe 'class methods' do
    it 'search method returns similar matches, case insensitive, alphabetically' do
      jimbob = Merchant.create(name: "Jimbob Dudeguy")
      jimmy = Merchant.create(name: "Jimmy John")
      james = Merchant.create(name: "James Rudemenn")

      example = Merchant.search("jim")
      example2 = Merchant.search("UdE")
      example3 = Merchant.search("ZlX")

      expect(example).to eq([jimbob, jimmy])
      expect(example2).to eq([james, jimbob])
      expect(example3).to eq([])
    end
  end
end
