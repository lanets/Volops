# frozen_string_literal: true

class StatisticsController < ApplicationController
  before_action :authenticate_user!
  skip_authorize_resource only: :index

  def index
    @event = Event.find(params[:event_id])
    # @availabilities = Availability.joins(:shift).where(shifts: {event_id: @event.id}).order(:user_id)
    @applications = @event.teams_applications
    @teams = @event.teams

    authorize! :show, @event
    authorize! :show, @teams
    authorize! :show, @applications
  end
end
