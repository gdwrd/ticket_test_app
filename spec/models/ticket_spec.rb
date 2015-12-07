require 'rails_helper'

RSpec.describe Ticket, type: :model do
  
  it "should create new ticket with nil informant" do
    ticket = FactoryGirl.create(:ticket)
    expect(ticket.ticket_informant).to equal(nil)
  end
  
end
