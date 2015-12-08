require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  describe "should get success response" do
    let(:ticket) { FactoryGirl.create(:ticket) }
    
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
  
  describe "guest ui tests: " do
    let(:ticket) { FactoryGirl.create(:ticket) }
    
    it "should create ticket" do
      visit "/tickets/new"
      fill_in "ticket_title", with: "Tets Ticket 001"
      fill_in "ticket_description", with: "Its Test Ticket description"
      fill_in "ticket_informant_username", with: "John"
      fill_in "ticket_informant_email", with: "john@example.com"
      click_button "create_ticket"
      expect(page.status_code).to eq(301)
      expect(page.current_url).to eq(ticket_url(Ticket.last.id))
    end
  end
   
  describe "user ui tests: " do
    let(:ticket) { Ticket.last }
   
    before(:each) do
      visit "/users/sign_in"
      fill_in 'user_email', with: 'john@example'
      fill_in 'user_password', with: 'secret123'
      click_button 'sing_in'
    end
     
    it "should update ticket" do
      visit "/ticket/edit", id: ticket.id
      select("WAITING FOR STAFF RESPONSE", from: "ticket_status")
      click_button "update_ticket"
      expect(page.status_code).to eq(301)
      expect(page.current_url).to eq(ticket_url(ticket.id))
      expect(Ticket.find(ticket.id).status).to eq(2)
    end
    
    it "should assign ticket on user" do
      visit "/ticket", id: ticket.id
      click_button 'assign_to_current_user_#{ticket.id}'
      expect(page.status_code).to eq(301)
      expect(page.current_url).to eq(edit_ticket_url(ticket.id))
    end
    
    it "should close ticket" do
      visit "/ticket", id: ticket.id
      click_button "close_ticket_#{ticket.id}"
      expect(Ticket.find(ticket.id).status).to eq(5)
      expect(page.status_code).to eq(301)
      expect(page.current_url).to eq(tickets_url)
    end
  end
end
