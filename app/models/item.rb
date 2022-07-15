class Item < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price
  validates_presence_of :merchant_id

  belongs_to :merchant

  def self.search_name(query)
    where("name ILIKE ?", "%#{query}%").order(:name)
  end

  def self.search_min(query)
    where("unit_price > ?", "#{query}").order(:name)
  end

  def self.search_max(query)
    where("unit_price < ?", "#{query}").order(:name)
  end
end
