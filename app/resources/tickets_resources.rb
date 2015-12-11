require './app/models/ticket.rb'
require './app/models/ticket_informant.rb'

class TicketsResouces
  include TicketsHelper
  attr_accessor :ticket, :ticket_informant, :data
  
  def initialize(data, ticket = nil, ticket_informant = nil)
    @data = data
    @ticket = ticket
    @ticket_informant = ticket_informant
  end
  
  def self.get_ticket(id)
    @ticket = Ticket.find(id)
  end
  
  def setup_resource(id)
    @ticket = Ticket.find(id)
    @ticket_informant = @ticket.ticket_informant
  end
  
  def save
    @ticket = Ticket.create(title: data[:title], description: data[:description])
    @ticket_informant = TicketInformant.create(username: data[:username], email: data[:email], ticket: ticket)
    generate_name_attribute
    set_default_status
  end
  
  def destroy
    @ticket.destroy!
  end
  
  def set_waiting_response_status
    @ticket.status = 1
  end
  
  def set_waiting_customer_status
    @ticket.status = 2
  end
  
  def set_on_hold_status
    @ticket.status = 3
  end
  
  def set_cancel_status
    @ticket.status = 4
  end
  
  def set_complete_status
    @ticket.status = 5
  end
  
  private
  
  def set_default_status
    set_waiting_response_status
  end
  
  def generate_name_attribute
    begin
      @ticket.name = "#{rand_str}-#{rand_hex}-#{rand_str}-#{rand_hex}-#{rand_str}-#{rand_hex}"
    end while @ticket.valid?
  end
end