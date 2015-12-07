class Ticket < ActiveRecord::Base
  belongs_to :user
  belongs_to :ticket_informant
  
  validates :name, presence: true, uniqueness: true
  validates :title, presence: true
  validates :description, presence: true
  validates :status, presence: true
  
  scope :open, -> { Ticket.where(status: 1) }
end
