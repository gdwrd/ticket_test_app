require 'rails_helper'

feature "User can" do
  given!(:user) { FactoryGirl.create(:user_with_tickets) }
  given!(:comment) { FactoryGirl.create(:comment) }
  given!(:ticket) { user.tickets.last }

  before(:each) do
    sign_in_with(user.email, user.password)
  end

  scenario "add comment to own ticket" do
    visit "/tickets/#{ticket.slug}"
    fill_in 'comment_message', with: comment.message
    click_button 'Add Comment'
    expect(page.current_url).to eq(ticket_url(ticket))
    expect(page.has_content?(comment.message)).to eq(true)
  end
end

feature "User can't" do
  given!(:ticket) { FactoryGirl.create(:ticket) }

  scenario "comment other ticket" do
    visit "/tickets/#{ticket.slug}"
    expect(page.has_content?('Add Comment')).to eq(false)
  end
end