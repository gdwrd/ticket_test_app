require 'rails_helper'

RSpec.describe User, type: :model do
  
  it "should create user with blank tickets references" do
    user = FactoryGirl.create(:user)
    expect(user.tickets.blank?).to equal(true)
  end
  
end
