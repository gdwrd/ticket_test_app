class TicketsController < ApplicationController
  before_action :authenticate_user!, except: [ :new, :create, :show ]
  
  def index
    @data = TicketsResources.tickets
    render :index
  end
  
  def new
    @ticket_form = TicketForm.new
  end
  
  def show
    @ticket = TicketsResources.get_ticket(params[:id])
  end
  
  def create
    @ticket_form = TicketForm.new(ticket_params)
    render :new if !@ticket_form.valid?
    @tickets_resources = TicketsResources.new(@ticket_form)
    redirect_to @tickets_resources.ticket if @tickets_resources.save
  end
  
  private
  
  def ticket_params
    params.require(:ticket_form).permit(:title, :description, :username, :email)
  end
  
end
