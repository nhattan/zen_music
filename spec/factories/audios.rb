FactoryGirl.define do
  factory :audio do
    name { Faker::Name.name }
    category
  end
end
