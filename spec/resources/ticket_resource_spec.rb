require './app/resources/tickets_resources.rb'

describe TicketsResources do
  describe "create ticket and ticket_informant objects" do
    let(:ticket) { FactoryGirl.create(:ticket) }
    let(:ticket_informant) { FactoryGirl.create(:ticket_informant) }
    let(:ticket_untreated) { 
      {
        title: ticket.title,
        description: ticket.description,
        username: ticket_informant.username,
        email: ticket_informant.email
      }
    }
    let(:ticket_untreated_empty) {
      {
        title: '',
        description: '',
        username: '',
        email: ''
      }
    }
    let(:tickets_resources) { TicketsResources.new(ticket_untreated) }
    
    it "and should get existing resources by ticket id" do
      tickets_resources.setup_resource(ticket.id)
      expect(tickets_resources.ticket).to eq(ticket)
      expect(tickets_resources.ticket_informant).to eq(ticket.ticket_informant)
    end
    
    it "and should destroy resource" do
      tickets_resources.setup_resource(ticket.id)
      tickets_resources.destroy
      # expect(tickets_resources.ticket).to eq(nil)
      # expect(tickets_resources.ticket_informant).to eq(nil)
      expect(Ticket.where(id: ticket.id)).to raise_exception(ActiveRecord::RecordNotFound)
      expect(TicketInformant.find(ticket_informant.id)).to raise_exception(ActiveRecord::RecordNotFound)
    end
    
    it "and should get ticket by id" do
      expect(TicketsResources.get_ticket(ticket.id)).to eq(ticket)
    end
    
    it "and should create new resource" do
      expect(tickets_resources.data).to eq(ticket_untreated)
      expect(tickets_resources.ticket).not_to eq(nil)
      expect(tickets_resources.ticket_informant).not_to eq(nil)
    end
    
    it "and should separate data" do
      tickets_resources.save
      ticket = tickets_resources.ticket
      ticket_informant = tickets_resources.ticket_informant
      
      expect(ticket.title).to eq(tickets_resources.data[:title])
      expect(ticket.description).to eq(tickets_resources.data[:description])
      expect(ticket_informant.email).to eq(tickets_resources.data[:email])
      expect(ticket_informant.username).to eq(tickets_resources.data[:username])
    end
    
    it "should change status" do
      tickets_resources.save
      tickets_resources.set_waiting_response_status
      expect(tickets_resources.ticket.status).to eq(1)
      
      tickets_resources.set_waiting_customer_status
      expect(tickets_resources.ticket.status).to eq(2)
      
      tickets_resources.set_on_hold_status
      expect(tickets_resources.ticket.status).to eq(3)
      
      tickets_resources.set_cancel_status
      expect(tickets_resources.ticket.status).to eq(4)
      
      tickets_resources.set_complete_status
      expect(tickets_resources.ticket.status).to eq(5)
    end
    
    it "and should save separate information, and generate name and status to db" do
      tickets_resources.save
      ticket = tickets_resources.ticket
      ticket_informant = tickets_resources.ticket_informant
      expect(tickets_resources.ticket.status).to eq(1)
      expect(tickets_resources.ticket.name).not_to eq(nil)
      expect(Ticket.last.title).to eq(ticket.title)
      expect(TicketInformant.last).to eq(ticket_informant)
    end
    
    it "and should return errors if ticket empty" do
      tickets_resources = TicketsResources.new(ticket_untreated_empty)
      expect(tickets_resources.valid?).to eq(false)
      expect(tickets_resources.errors).not_to eq(nil)
    end
  end
end