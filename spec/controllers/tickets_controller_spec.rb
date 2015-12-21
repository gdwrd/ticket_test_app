require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  include Devise::TestHelpers
  
  describe "should get success response" do
    let(:ticket) { FactoryGirl.create(:ticket) }
    
    it "to #new" do
      get 'new'
      expect(response).to render_template(:new)
      expect(response.status).to eq(200)
    end
    
    it "shouldn't request success to #index" do
      get 'index'
      expect(response.status).to eq(302)
      expect(response).to redirect_to(new_user_session_url)
    end
    
    it "shouldn't request success to #update" do
      patch 'update', id: ticket.id, ticket: { title: "Changed Ticket Title" }
      expect(response.status).to eq(302)
      expect(response).to redirect_to(new_user_session_url)
    end
    
    it "shouldn't request success to #delete" do
      delete 'destroy', id: ticket.id
      expect(response.status).to eq(302)
      expect(response).to redirect_to(new_user_session_url)
    end
  end
  
  describe "should get success response" do
    let(:ticket) { FactoryGirl.create(:ticket) }
    let(:user) { FactoryGirl.create(:user) }
    
    before(:each) do
      sign_in user
    end
    
    it "from #index" do
      get "index"
      expect(response.status).to eq(200)
      expect(response).to render_template(:index)
    end
    
    it "from #show" do
      get "show", id: ticket.slug
      expect(response.status).to eq(200)
    end
  end
end
