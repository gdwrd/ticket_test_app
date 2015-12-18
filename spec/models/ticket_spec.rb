require 'rails_helper'

RSpec.describe Ticket, type: :model do
  
  it "shouldn't create new ticket with nil informant" do
    ticket = FactoryGirl.create(:ticket)
    ticket.ticket_informant = nil
    expect(ticket.valid?).to eq(false)
  end
  
  describe "should" do
    it "have user if status 2" do
      ticket = FactoryGirl.create(:ticket_with_status_2)
      expect(ticket.user.nil?).to eq(false)
    end
    
    it "have user if status 3" do
      ticket = FactoryGirl.create(:ticket_with_status_3)
      expect(ticket.user.nil?).to eq(false)
    end
    
    it "have user if status 4" do
      ticket = FactoryGirl.create(:ticket_with_status_4)
      expect(ticket.user.nil?).to eq(false)
    end
    
    it "have user if status 5" do
      ticket = FactoryGirl.create(:ticket_with_status_5)
      expect(ticket.user.nil?).to eq(false)
    end
  end
  
end
