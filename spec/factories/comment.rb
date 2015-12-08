FactoryGirl.define do
  factory :comment do
    sequence(:message) { |n| "Hi, it's just a test comment #{n}" }
    
    association :ticket
    association :user
  end
end