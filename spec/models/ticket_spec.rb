require 'rails_helper'

RSpec.describe Ticket, type: :model do
  
  it "shouldn't create new ticket with nil informant" do
    ticket = FactoryGirl.create(:ticket)
    ticket.ticket_informant = nil
    expect(ticket.valid?).to eq(false)
  end
  
  describe "statuses should" do
    it "have user if status 2" do
      ticket = FactoryGirl.create(:ticket_with_status_2)
      expect(ticket.user).not_to eq(nil)
    end
  end
  
end
