require 'rails_helper'

RSpec.describe TicketsHelper, type: :helper do
  describe "#ticket" do
    before do
      @ticket = FactoryGirl.create(:ticket)
    end
    
    it "should return label_class_by_status" do
      @ticket.status = 1
      expect(label_class_by_status).to eq('label-info')
      @ticket.status = 3
      expect(label_class_by_status).to eq('label-default')
      @ticket.status = 4
      expect(label_class_by_status).to eq('label-danger')
      @ticket.status = 5
      expect(label_class_by_status).to eq('label-success')
    end
  end
end
