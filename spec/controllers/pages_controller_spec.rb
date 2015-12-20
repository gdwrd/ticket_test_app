require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe "should get success response" do
    it "from #about" do
      get "about"
      expect(response).to render_template(:about)
      expect(response.status).to eq(200)
    end
  end  
  
end
