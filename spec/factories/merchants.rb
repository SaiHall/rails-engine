FactoryBot.define do
  factory :merchant do
    name { Faker::JapaneseMedia::StudioGhibli.character }
    after(:create) do |merchant|
      create_list :item, 4, merchant: merchant
    end
  end
end
