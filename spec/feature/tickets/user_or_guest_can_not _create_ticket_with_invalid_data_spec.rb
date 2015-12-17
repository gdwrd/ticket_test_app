require 'rails_helper'

feature "user or guest can not" do
  given!(:count) { Ticket.all.length }
  
  scenario "create ticket with invalid data" do
    visit "/tickets/new"
    fill_in 'ticket_form[title]', with: ''
    fill_in 'ticket_form[description]', with: ''
    fill_in 'ticket_form[username]', with: ''
    fill_in 'ticket_form[email]', with: ''
    click_button 'Create ticket'
    expect(Ticket.all.length).to eq(count)
  end
end