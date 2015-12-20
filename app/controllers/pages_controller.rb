class PagesController < ApplicationController
  before_action :authenticate_user!, except: [ :about ]

  def home
    @recent = TicketsResources.recent
    @updated = TicketsResources.updated
  end
  
  def about
  end
end
