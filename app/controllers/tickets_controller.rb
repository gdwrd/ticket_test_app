class TicketsController < ApplicationController
  before_action :authenticate_user!, except: [ :new, :create, :show ]
  
  def index
  end
  
end
