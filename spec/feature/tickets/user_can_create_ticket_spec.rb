require 'rails_helper'

feature "User can" do
  given!(:ticket) { FactoryGirl.create(:ticket) }
  given!(:user) { FactoryGirl.create(:user) }
  
  before(:each) do
    sign_in_with(user.email, user.password)
  end
  
  scenario "create ticket" do
    visit "/tickets/new"
    fill_in 'ticket_title', with: ticket.title
    fill_in 'ticket_description', with: title.description
    fill_in 'ticket_username', with: ticket.ticket_informant.username
    fill_in 'ticket_email', with: ticket.ticket_informant.email
    click_button 'Create Ticket'
    expect(page).to has_content("Your ticket successfully created, check you mailbox - #{ticket.ticket_informant.email} for updates!")
  end
end