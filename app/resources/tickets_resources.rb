require './app/models/ticket.rb'
require './app/models/ticket_informant.rb'

class TicketsResources
  include TicketsHelper
  attr_accessor :ticket, :ticket_informant, :data, :errors

  class << self
    def tickets
      {
          open: Ticket.open,
          with_response: Ticket.with_response,
          hold: Ticket.hold,
          canceled: Ticket.canceled,
          completed: Ticket.completed
      }
    end

    def get_ticket(id)
      @ticket = Ticket.find_by(slug: id)
    end
  end
  
  def initialize(data = nil, ticket = nil, ticket_informant = nil)
    @data = data
    @ticket = ticket
    @ticket_informant = ticket_informant
    @errors = nil
    separate_data if !@data.nil?
  end

  def setup_resource(id)
    @ticket = Ticket.find_by(slug: id)
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
  
  def self.method_missing(name, *args, &block)
    Ticket.send name, *args, &block
  end
  
  def self.respond_to?(name, include_private = false)
    Ticket.methods.include? name || super
  end
  
  private
  
    def assign_to_current_user(user_id)
      @ticket.user_id = user_id
    end

    def set_default_status
      @ticket.status = 1
    end

    def generate_name_attribute
      loop do
        @ticket.name = "#{rand_str}-#{rand_hex}-#{rand_str}-#{rand_hex}-#{rand_str}-#{rand_hex}"
        break if @ticket.valid?
      end
    end
end