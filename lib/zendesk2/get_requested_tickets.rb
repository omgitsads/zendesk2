# frozen_string_literal: true
class Zendesk2::GetRequestedTickets
  include Zendesk2::Request

  request_method :get
  request_path do |r| "/users/#{r.requester_id}/tickets/requested.json" end

  page_params!

  def requester_id
    params.fetch('requester_id').to_i
  end

  def mock(_params = {})
    tickets = data[:tickets].values.select { |u| u['requester_id'] == requester_id }

    page(tickets, root: 'tickets')
  end
end
