class TicketForm
  include Virtus.model
  
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attribute :title, String
  attribute :description, String
  attribute :username, String
  attribute :email, String
  
  validates :title, presence: true
  validates :description, presence: true
  validates :username, presence: true
  validates :email, presence: true
end