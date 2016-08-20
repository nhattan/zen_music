FactoryGirl.define do
  factory :category do
    sequence(:name){ Faker::Music.instrument }
  end
end
