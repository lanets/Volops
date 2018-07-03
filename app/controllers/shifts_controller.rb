class ShiftsController < ApplicationController
  load_and_authorize_resource

  def index
    @event = Event.find(params[:event_id])
    @shifts = Shift.where(event_id: @event.id)
  end
end