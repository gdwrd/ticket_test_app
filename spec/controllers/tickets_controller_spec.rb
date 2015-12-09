require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  include Devise::TestHelpers
  
  describe "should not get success response" do
    before(:each) do
      Capybara.reset_sessions!
    end
    
    it "shouldn't request success to #index" do
      get 'index'
      expect(response.status).to eq(302)
      expect(page.current_url).to eq(new_user_session_url)
    end
    
    it "shouldn't request success to #edit" do
      get 'edit'
      expect(response.status).to eq(302)
      expect(page.current_url).to eq(new_user_session_url)
    end
    
    it "shouldn't request success to #update" do
      post 'update', ticket: ticket
      expect(response.status).to eq(302)
      expect(page.current_url).to eq(new_user_session_url)
    end
    
    it "shouldn't request success to #delete" do
      delete 'destroy', id: ticket.id
      expect(response.status).to eq(302)
      expect(page.current_url).to eq(new_user_session_url)
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
    end
    
    it "from #new" do
      get "new"
      expect(response.status).to eq(200)
    end
    
    it "from #show" do
      get "show", id: ticket.id
      expect(response.status).to eq(200)
    end
    
    it "from #edit" do
      get "edit", id: ticket.id
      expect(response.status).to eq(200)
    end
  end
end
