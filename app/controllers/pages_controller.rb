class PagesController < ApplicationController
  def home
    @recent = TicketsResources.recent
    @updated = TicketsResources.updated
  end
  
  def about
  end
end
