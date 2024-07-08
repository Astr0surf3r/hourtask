# spec/factories/projects.rb
FactoryBot.define do
    factory :project do
      name { "Sample Project" }
      association :company
      association :user
    end
end
