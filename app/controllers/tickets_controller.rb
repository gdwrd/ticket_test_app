class TicketsController < ApplicationController
  before_action :authenticate_user!, except: [ :new, :create, :show ]
  before_action :set_ticket, only: [:show, :edit, :update]
  
  def index
    @data = TicketsResources.tickets
    render :index
  end
  
  def new
    @ticket_form = TicketForm.new
  end
  
  def show
  end
  
  def create
    @ticket_form = TicketForm.new(ticket_params)
    if @ticket_form.valid?
      @tickets_resources = TicketsResources.new(@ticket_form)
      redirect_to @tickets_resources.ticket if @tickets_resources.save
    else
      render :new
    end
  end
  
  def update
    @tickets_resources = TicketsResources.new
    @tickets_resources.setup_resource(@ticket.id)
    @tickets_resources.update(ticket_params, current_user.id)
    redirect_to tickets_path
  end
  
  private
  
  def ticket_params
    params.require(:ticket_form).permit(:title, :description, :username, :email, :status)
  end
  
  def set_ticket
    @ticket = TicketsResources.get_ticket(params[:id])
  end
end