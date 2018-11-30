module Organizer
  class OpportunitiesController < OrganizerController
    def index
      @opportunities = current_organization.opportunities.includes(:charisms).order(:name)
    end

    def new
      @opportunity = current_organization.opportunities.new
      @charisms = Charism.order(:name)
    end

    def create
      @opportunity = current_organization.opportunities.new(opportunity_params)
      @charisms = Charism.order(:name)

      if @opportunity.save
        redirect_to organizer_opportunities_path
      else
        flash.now[:alert] = "Could not create opportunity"
        render action: :new
      end
    end

    def edit
      @opportunity = current_organization.opportunities.includes(:charisms).find(params[:id])
      @charisms = Charism.order(:name)
    end

    def update
      @opportunity = current_organization.opportunities.find(params[:id])
      @charisms = Charism.order(:name)

      if @opportunity.update(opportunity_params)
        flash[:success] = "Updated opportunity #{@opportunity.name}"
        redirect_to organizer_opportunities_path
      else
        flash.now[:alert] = "Could not update opportunity"
        render action: :edit
      end
    end


    private

    def opportunity_params
      params.require(:opportunity).permit(:name, :description, charism_ids: []).tap do |params|
        # if no charisms were selected, there would be no key in the params, so instead, default it to an empty array
        params[:charism_ids] = [] unless params.has_key?(:charism_ids)
      end
    end
  end
end
