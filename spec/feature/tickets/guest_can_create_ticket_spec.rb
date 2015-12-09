require 'rails_helper'

feature "Guest can create ticket" do
  given!(:ticket) { FactoryGirl.create(:ticket) }
  
  scenario "with valid fields" do
    visit "/tickets/new"
    fill_in 'ticket_title', with: ticket.title
    fill_in 'ticket_description', with: title.description
    fill_in 'ticket_username', with: ticket.ticket_informant.username
    fill_in 'ticket_email', with: ticket.ticket_informant.email
    click_button 'Create Ticket'
    expect(page).to has_content("Your ticket successfully created, check you mailbox - #{ticket.ticket_informant.email} for updates!")
  end
end