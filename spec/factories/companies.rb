# spec/factories/companies.rb
FactoryBot.define do
  factory :company do
    association :user
    name { "Sample Company" }
  end
end