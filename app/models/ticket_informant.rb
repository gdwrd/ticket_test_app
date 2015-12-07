class TicketInformant < ActiveRecord::Base
  has_one :ticket
  
  validates :username, presence: true
  validates :email, presence: true
end
