require 'rails_helper'

feature "User can" do
  given!(:user) { FactoryGirl.create(:user) }

  before(:each) do
    sign_in_with(user.email, user.password)
  end

  scenario "see home page" do
    visit "/"
    expect(page.current_url).to eq(root_url)
  end
end