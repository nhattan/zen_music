FactoryGirl.define do
  factory :transaction do
    user
    amount { Faker::Number.positive.floor }
  end
end
