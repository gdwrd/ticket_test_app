require 'rails_helper'

RSpec.describe TicketsController, type: :routing do
  
  # get request specs
  it { expect(get("/tickets")).to route_to("tickets#index") }
  it { expect(get("/tickets/new")).to route_to("tickets#new") }
  it { expect(get("/tickets/1/edit")).to_not be_routable }
  
  # post request specs
  it { expect(post("/tickets")).to route_to("tickets#create") }
end