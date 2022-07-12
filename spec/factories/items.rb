FactoryBot.define do
  factory :item do
  name { Faker::Games::Zelda.item}
  description { Faker::Quotes::Shakespeare.as_you_like_it_quote }
  unit_price { Faker::Number.between(from: 100, to: 100000) }
  end
end
