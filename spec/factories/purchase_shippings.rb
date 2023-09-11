FactoryBot.define do
  factory :purchase_shipping do
    postal_code { Faker::Number.between(from: 100, to: 999).to_s + "-" + Faker::Number.between(from: 1000, to: 9999).to_s }
    prefecture_id {Faker::Number.between(from: 2, to: 48)}
    city { Faker::Address.city }
    address { Faker::Address.street_address }
    building { Faker::Address.secondary_address }
    phone_number { Faker::Number.number(digits: rand(10..11)) }
    token {"tok_abcdefghijk00000000000000000"}
  end
end