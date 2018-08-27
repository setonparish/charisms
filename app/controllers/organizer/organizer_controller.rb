class Organizer::OrganizerController < ApplicationController
  before_action :authenticate_user!
  layout "organizer"

  def index
  end
end
