require 'rails_helper'

feature "User can" do
  given!(:user) { FactoryGirl.create(:user_with_tickets) }
  given!(:ticket) { FactoryGirl.create(:ticket) }
  given!(:comment) { FactoryGirl.create(:comment) }

  before(:each) do
    sign_in_with(user.email, user.password)
  end

  scenario "add comment to own ticket" do
    visit "/tickets/#{Ticket.last.slug}"
    fill_in 'comment[message]', with: comment.message
    click_button 'Add Comment'
    expect(page.current_url).to eq(ticket_url(ticket))
    expect(page.has_content?(comment.message)).to eq(true)
  end
end

feature "User can't comment other ticket" do
  visit "/tickets/#{ticket.slug}"
  expect(page.has_content?('Add Comment')).to eq(false)
  expect(page.has_content?('You have not access to comment this ticket')).to eq(true)
end