module Organizer
  class WebLinksController < OrganizerController
    def index
      @web_links = current_organization.web_links.order(created_at: :desc)
    end

    def new
      @web_link = WebLink.new
    end

    def create
      @web_link = WebLink.new(web_link_params.merge(organization: current_organization, survey: Survey.default))

      if @web_link.save
        redirect_to organizer_web_links_path
      else
        flash.now[:alert] = "Could not create link"
        render action: :new
      end
    end

    def edit
      @web_link = current_organization.web_links.friendly.find(params[:id])
    end

    def update
      @web_link = current_organization.web_links.friendly.find(params[:id])

      if @web_link.update(web_link_params)
        flash[:success] = "Updated link #{@web_link.name}"
        redirect_to organizer_web_links_path
      else
        flash.now[:alert] = "Could not update link"
        render action: :edit
      end
    end


    private

    def web_link_params
      params.require(:web_link).permit(:name)
    end
  end
end
