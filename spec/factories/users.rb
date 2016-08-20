FactoryGirl.define do
  factory :user do
    sequence(:name){ Faker::Name.name }
    sequence(:email){ |i| Faker::Internet.email }
    password  "123123123"
  end
end
