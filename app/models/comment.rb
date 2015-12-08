class Comment < ActiveRecord::Base
  belongs_to :ticket, dependent: :destroy
  belongs_to :user
  
  validates :user, presence: true
  validates :ticket, presence: true
  validates :message, presence: true
end
