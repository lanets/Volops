class SchedulesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @event = Event.find(params[:event_id])
    @requirements = Requirement.where(event_id: @event.id)
    @availabilities = Availability.joins(:shift).where(shifts: {event_id: @event.id} )
    @shifts = Shift.where(event_id: @event.id)
    @users = User.find(@availabilities.map(&:user_id))
  end

end