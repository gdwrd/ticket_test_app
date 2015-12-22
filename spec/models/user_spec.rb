require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:user_with_tickets) { FactoryGirl.create(:user_with_tickets) }
  
  it "should create user with blank tickets references" do
    expect(user.tickets.blank?).to equal(true)
  end
  
  it "should create user with tickets" do
    expect(user_with_tickets.tickets.last.ticket_informant).not_to eq(nil)
  end

  it "should destroy users tickets" do
    last_ticket = user_with_tickets.tickets.last
    user_with_tickets.destroy
    expect(Ticket.where(last_ticket.id).blank?).to eq(true)
  end
end
