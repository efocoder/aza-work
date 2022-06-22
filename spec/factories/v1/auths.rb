# frozen_string_literal: true

FactoryBot.define do
  factory :auth, class: 'V1::Auth' do
    email { Faker::Internet.email }
    password { 'pas123456' }
  end
end
