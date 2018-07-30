class StatisticsController < ApplicationController
  before_action :authenticate_user!
  skip_authorize_resource :only => :index

  def index
    @event = Event.find(params[:event_id])
    # @availabilities = Availability.joins(:shift).where(shifts: {event_id: @event.id}).order(:user_id)
    @applications = TeamsApplication.where(event_id: @event.id)
    @teams = Team.where(event_id: @event.id)

    authorize! :show, @event
    authorize! :show, @teams
    authorize! :show, @applications

  end

end