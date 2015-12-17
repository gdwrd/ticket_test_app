require './app/models/ticket.rb'
require './app/models/ticket_informant.rb'

class TicketsResources
  include TicketsHelper
  attr_accessor :ticket, :ticket_informant, :data, :errors
  
  def initialize(data = nil, ticket = nil, ticket_informant = nil)
    @data = data
    @ticket = ticket
    @ticket_informant = ticket_informant
    @errors = nil
    separate_data if !@data.nil?
  end
  
  def self.tickets
    {
      open: Ticket.open,
      with_response: Ticket.with_response,
      hold: Ticket.hold,
      canceled: Ticket.canceled,
      completed: Ticket.completed
    }
  end
  
  def self.get_ticket(id)
    @ticket = Ticket.find(id)
  end
  
  def setup_resource(id)
    @ticket = Ticket.find(id)
    @ticket_informant = @ticket.ticket_informant
  end
  
  def save
    set_default_status
    generate_name_attribute
    true if @ticket.save
  end
  
  def update(ticket_params, user_id)
    assign_to_current_user(user_id) if @ticket.user.nil?
    @ticket.update(ticket_params)
  end
  
  def separate_data
    @ticket = Ticket.create(title: data[:title], description: data[:description])
    @ticket_informant = TicketInformant.create(username: data[:username], email: data[:email], ticket: ticket)
    @ticket.ticket_informant = @ticket_informant
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
  
  def assign_to_current_user(user_id)
    @ticket.user_id = user_id
  end
  
  def set_default_status
    set_waiting_response_status
  end
  
  def generate_name_attribute
    loop do
      @ticket.name = "#{rand_str}-#{rand_hex}-#{rand_str}-#{rand_hex}-#{rand_str}-#{rand_hex}"
      break if @ticket.valid?
    end
  end
end