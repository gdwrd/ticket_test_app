require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  it "should get response from #home page" do
    get "home"
    expect(response.status).to eq(200)
  end
end
