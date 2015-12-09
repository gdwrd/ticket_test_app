require 'rails_helper'

feature 'User can update ticket' do
  
  given!(:ticket) { FactoryGirl.create(:ticket) }
  given!(:user) { FactoryGirl.create(:ticket) }
  
  before(:each) do
    visit "/users/sign_in"
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Sign in'
  end
  
  scenario "and change status" do
    visit "/tickets", id: ticket.id
    select("WAITING FOR STAFF RESPONSE", from: "ticket_status")
    click_button "update_ticket"
    expect(page.status_code).to eq(200)
    expect(page.current_url).to eq(ticket_url(ticket.id))
    expect(Ticket.find(ticket.id).status).to eq(2)
  end
  
  scenario "assign to user, from #show" do
    visit "/tickets", id: ticket.id
    click_button "Assing to Me"
    expect(page.status_code).to eq(200)
    expect(page.current_url).to eq(ticket_url(ticket.id))
    expect(Ticket.find(ticket.id).user).not_to eq(nil)
  end
  
  scenario "close ticket from #show" do
    visit "/tickets", id: ticket.id
    click_button "Close Ticket"
    expect(page.status_code).to eq(200)
    expect(page.current_url).to eq(tickets_url)
    expect(Ticket.find(ticket.id).status).to eq(5)
  end
  
  scenario "assign to user, from #index" do
    visit "/tickets"
    click_button "assign_#{ticket.id}"
    expect(page.status_code).to eq(200)
    expect(page.current_url).to eq(ticket_url(ticket.id))
    expect(Ticket.find(ticket.id).user).not_to eq(nil)
  end
end