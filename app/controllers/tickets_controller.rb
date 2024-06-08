class TicketsController < ApplicationController
  before_action :authenticate_user!  # Assuming Devise for authentication

  def new
    @ticket = Ticket.new
  end

  def create
    @ticket = current_user.tickets.new(ticket_params)
    @ticket.link = request.referer

    if @ticket.save
      jira_ticket = create_jira_ticket(@ticket)
      if jira_ticket
        # @ticket.update(jira_key: jira_ticket.key, status: jira_ticket.status.name)
        # redirect_to user_tickets_path(current_user), notice: "Ticket created successfully."
      else
        @ticket.destroy
        flash[:alert] = "There was an error creating the JIRA ticket."
        render :new
      end
    else
      render :new
    end
  end

  def index
    @tickets = current_user.tickets.page(params[:page]).per(10)
  end

  private

  def ticket_params
    params.require(:ticket).permit(:summary, :priority, :collection)
  end

  def create_jira_ticket(ticket)
    issue = JIRA_CLIENT.Issue.build
    issue.save({
                 "fields" => {
                   "summary"     => ticket.summary,
                   "description" => "Link: #{ticket.link}\nCollection: #{ticket.collection}",
                   "project"     => { "key" => "IP" },
                   "issuetype"   => { "name" => "Task" },
                   "priority"    => { "name" => ticket.priority },
                   "assignee"    => { "name" => current_user.email },
                   "reporter"    => { "name" => current_user.email }
                 }
               })
    issue.fetch
  rescue JIRA::HTTPError => e
    logger.error "JIRA ticket creation failed: #{e.message}"
    nil
  end
end
