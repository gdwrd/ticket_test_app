require 'rails_helper'

feature "Guest can create ticket" do
  given!(:ticket) { FactoryGirl.create(:ticket) }
  
  scenario "with valid fields" do
    visit "/tickets/new"
    fill_in 'ticket_form[title]', with: ticket.title
    fill_in 'ticket_form[description]', with: ticket.description
    fill_in 'ticket_form[username]', with: ticket.ticket_informant.username
    fill_in 'ticket_form[email]', with: ticket.ticket_informant.email
    click_button 'Create ticket'
    expect(page.has_content?(ticket.title)).to eq(true)
  end
end