module Organizer
  class ReportsController < OrganizerController
    def index
      @web_links = current_organization.web_links.order(created_at: :desc)
      @summaries = CharismSummary.new(web_links: @web_links)
    end
  end
end
