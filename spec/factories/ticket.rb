FactoryGirl.define do
  factory :ticket do
    sequence(:title) { |n| "TEST-#{n}, this is test title for Rspec tests" }
    sequence(:name) { |n| "RND-TICKET-NAME-##{n}" }
    description "This is simple description for this test ticket"
    status 1
    association :ticket_informant
    
    factory :ticket_with_status_2 do
      status 2
    end
  end
end