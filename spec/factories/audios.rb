FactoryGirl.define do
  factory :audio do
    sequence(:name){ Faker::Name.name }
    category
  end
end
