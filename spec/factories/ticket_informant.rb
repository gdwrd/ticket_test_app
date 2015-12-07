FactoryGirl.define do
  factory :ticket_informant do
    sequence(:email) { |n| "john_#{n}@example.com" }
    sequence(:username) { |n| "John #{n}" }
    
    factory :ticket_informant_with_ticket do
      association :ticket
    end
  end
end