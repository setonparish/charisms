module Organizer
  class WebLinksController < OrganizerController
    def index
      @web_links = current_user.web_links
    end
  end
end
