require './app/resources/tickets_resources.rb'

describe TicketsResources do
  describe "create ticket and ticket_informant objects" do
    let(:user) { FactoryGirl.create(:user) }
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
    let(:update_ticket_params) { { status: 2 } }
    
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
      expect(Ticket.where(ticket.id).blank?).to eq(true)
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
    
    it "and should save separate information, and generate name and status to db" do
      tickets_resources.save
      ticket = tickets_resources.ticket
      ticket_informant = tickets_resources.ticket_informant
      expect(tickets_resources.ticket.status).to eq(1)
      expect(tickets_resources.ticket.name).not_to eq(nil)
      expect(Ticket.last.title).to eq(ticket.title)
      expect(TicketInformant.last).to eq(ticket_informant)
    end
    
    it "Update ticekt: should change status" do
      tickets_resources.update(update_ticket_params, user.id)
      expect(tickets_resources.ticket.status).to eq(2)
      expect(tickets_resources.ticket.user.nil?).to eq(false)
    end
  end

  describe "accessing to Ticket scopes:" do
    it { expect(TicketsResources.respond_to? :recent) }
    it { expect(TicketsResources.respond_to? :updated) }
  end
end