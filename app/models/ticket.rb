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
end
