FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "john_#{n}@example.com" }
    password "secret123"
    
    factory :user_with_tickets do
      
      transient do
        tickets_count 5
      end
      
      after(:create) do |user, evaluator|
        create_list(:ticket, evaluator.tickets_count, user: user)
      end
    end
  end
end