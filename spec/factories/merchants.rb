FactoryBot.define do
  FactoryBot.define do
    factory :merchant do
      name { Faker::JapaneseMedia::StudioGhibli.character }
    end
  end
end
