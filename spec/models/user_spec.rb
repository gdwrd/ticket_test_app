require 'rails_helper'

RSpec.describe User, type: :model do
  
  it "should create user with blank tickets references" do
    user = FactoryGirl.create(:user)
    expect(user.tickets.blank?).to equal(true)
  end
  
  it "should create user with tickets" do
    user = FactoryGirl.create(:user_with_tickets)
    expect(user.tickets.last.ticket_informant).not_to eq(nil)
  end
end
