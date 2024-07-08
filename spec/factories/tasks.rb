# spec/factories/tasks.rb
FactoryBot.define do
    factory :task do
        association :user
        association :project  
    end
end
  