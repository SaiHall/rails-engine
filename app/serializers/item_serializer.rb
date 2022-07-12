class ItemSerializer

  def self.items_from_merchant(merchant) #make formatted unit price item instance method
    {
      data: merchant.items.map do |item|
        {
          id: "#{item.id}",
          type: "item",
          attributes: {
            name: item.name,
            description: item.description,
            unit_price: item.unit_price * 0.01,
            merchant_id: merchant.id
          }
        }
      end
    }
  end
end
