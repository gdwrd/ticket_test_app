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
  scope :open, -> { where(status: 1) }
  scope :with_response, -> { where(status: 2) }
  scope :hold, -> { where(status: 3) }
  scope :canceled, -> { where(status: 4) }
  scope :completed, -> { where(status: 5) }
  
  scope :recent, -> { order("created_at DESC").limit(5) }
  scope :updated, -> { order("updated_at DESC").limit(5) }
end
