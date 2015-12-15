class Ticket < ActiveRecord::Base
  belongs_to :user
  belongs_to :ticket_informant
  has_many :comments
  
  validates :ticket_informant, presence: true
  validates :name, presence: true, uniqueness: true
  validates :title, presence: true
  validates :description, presence: true
  validates :status, presence: true
  validates_associated :ticket_informant
  
  scope :open, -> { Ticket.where(status: 1) }
  scope :with_response, -> { Ticket.where(status: 2) }
  scope :hold, -> { Ticket.where(status: 3) }
  scope :canceled, -> { Ticket.where(status: 4) }
  scope :completed, -> { Ticket.where(status: 5) }
end
