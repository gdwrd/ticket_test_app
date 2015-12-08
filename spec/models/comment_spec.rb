require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "always should" do
    let(:comment) { FactoryGirl.create(:comment) }
    
    it "have a user dependency" do
      comment.user = nil
      expect(comment.valid?).to eq(false)
      expect(comment.errors.messages[:user][0]).to eq("can't be blank")
    end
    
    it "have a ticket dependency" do
      comment.ticket = nil
      expect(comment.valid?).to eq(false)
      expect(comment.errors.messages[:ticket][0]).to eq("can't be blank")
    end
  end
end
