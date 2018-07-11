class RequirementsController < ApplicationController
  load_and_authorize_resource

  def index
    @event = Event.find(params[:event_id])
    @requirements = Requirement.where(event_id: @event.id)
  end

  def new
    @event = Event.find(params[:event_id])
    @requirement = Requirement.new
  end

  def create
    @event = Event.find(params[:event_id])
  end

  def show
    @event = Event.find(params[:event_id])
  end
end