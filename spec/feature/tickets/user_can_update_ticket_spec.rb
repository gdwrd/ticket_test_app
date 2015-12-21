require 'rails_helper'

feature 'User can update ticket' do
  given!(:ticket) { FactoryGirl.create(:ticket) }
  given!(:user) { FactoryGirl.create(:user) }
  
  before(:each) do
    sign_in_with(user.email, user.password)
  end
  
  scenario "assign to user, from #show" do
    visit "/tickets/#{ticket.slug}"
    click_button "Assign"
    expect(page.status_code).to eq(200)
    expect(page.current_url).to eq(tickets_url)
    expect(Ticket.find(ticket.id).user.nil?).to eq(false)
  end
  
  scenario "cancel ticket from #show" do
    visit "/tickets/#{ticket.slug}"
    click_button "Canceled"
    expect(page.status_code).to eq(200)
    expect(page.current_url).to eq(tickets_url)
    expect(Ticket.find(ticket.id).status).to eq(4)
  end
  
  scenario "hold ticket from #show" do
    visit "/tickets/#{ticket.slug}"
    click_button "Hold"
    expect(page.status_code).to eq(200)
    expect(page.current_url).to eq(tickets_url)
    expect(Ticket.find(ticket.id).status).to eq(3)
  end
  
  scenario "complete ticket from #show" do
    visit "/tickets/#{ticket.slug}"
    click_button "Delete"
    expect(page.status_code).to eq(200)
    expect(page.current_url).to eq(tickets_url)
    expect(Ticket.where(ticket.id).blank?).to eq(true)
  end
  
  scenario "complete ticket from #show" do
    visit "/tickets/#{ticket.slug}"
    click_button "Complete"
    expect(page.status_code).to eq(200)
    expect(page.current_url).to eq(tickets_url)
    expect(Ticket.find(ticket.id).status).to eq(5)
  end
  
  scenario "assign to user, from #index" do
    visit "/tickets"
    click_button "Assign"
    expect(page.status_code).to eq(200)
    expect(page.current_url).to eq(tickets_url)
    expect(Ticket.find(ticket.id).user.nil?).to eq(false)
  end
end