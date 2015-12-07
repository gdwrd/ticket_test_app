require 'rails_helper'

RSpec.describe TicketInformant, type: :model do
  
  it "should have nil ticket" do
    informant = FactoryGirl.create(:ticket_informant)
    expect(informant.ticket).to eq(nil)
  end
  
  it "should have factory ticket" do
    informant = FactoryGirl.create(:ticket_informant_with_ticket)
    expect(informant.ticket).not_to eq(nil)
  end
  
end
