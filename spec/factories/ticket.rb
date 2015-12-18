FactoryGirl.define do
  factory :ticket do
    sequence(:title) { |n| "TEST-#{n}, this is test title for Rspec tests" }
    sequence(:name) { |n| "RND-TICKET-NAME-##{n}" }
    description "This is simple description for this test ticket"
    status 1
    association :ticket_informant
    
    factory :ticket_with_status_2 do
      status 2
      association :user
      
      factory :ticket_with_status_3 do
        status 3
      end
      
      factory :ticket_with_status_4 do
        status 4
      end
      
      factory :ticket_with_status_5 do
        status 5
      end
    end
  end
end