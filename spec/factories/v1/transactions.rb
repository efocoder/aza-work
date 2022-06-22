FactoryBot.define do
  factory :transaction, class: 'V1::Transaction' do
    # transaction_id { "MyString" }
    customer_id { Faker::Alphanumeric.alphanumeric(number: 14) }
    input_currency { Faker::Currency.code }
    input_amount { Faker::Number.decimal(r_digits: 3) }
    output_currency { Faker::Currency.code }
    output_amount { Faker::Number.decimal(r_digits: 3) }
  end
end
