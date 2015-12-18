module TicketsHelper
  TICKETS_STATUS_LIST = [
      [ "Waiting for Stuff Response", 1 ],
      [ "Waiting for Customer", 2 ],
      [ "On Hold", 3 ],
      [ "Canceled", 4 ],
      [ "Completed", 5 ]
    ]
  
  def rand_str
    (0...3).map { ('A'..'Z').to_a[rand(26)] }.join
  end
  
  def rand_hex
    SecureRandom.hex(1)
  end
  
  def tickets_panel(tickets, scope_name)
    @tickets = tickets
    @scope = scope_name
    render :partial => "tickets_panel"
  end
  
  def update_ticket_status_path(id, status)
    {
      controller: "tickets",
      action: "update",
      id: id,
      ticket_form: {
        status: status
      }
    }
  end
  
  def ticket_status_label
    status = TICKETS_STATUS_LIST[@ticket.status - 1][0]
    render inline: "<span class='label #{label_class_by_status}'>#{status}</span>"
  end
  
  def label_class_by_status
    case @ticket.status
    when 1, 2
      "label-info"
    when 3
      "label-default"
    when 4
      "label-danger"
    else
      "label-success"
    end
  end
  
  def user_actions
    if !current_user.nil?
      render :partial => 'action_block'
    end
  end
end
