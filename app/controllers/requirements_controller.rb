class RequirementsController < ApplicationController
  load_and_authorize_resource

  def index
    @event = Event.find(params[:event_id])
    @requirements = Requirement.where(event_id: @event.id).joins(:shift, :team).order('shift_id')
    @teams = Team.where(event_id: @event.id)
    @shifts = Shift.where(event_id: @event.id)
  end

  def new
    @event = Event.find(params[:event_id])
    @requirement = Requirement.new
  end

  def create
    @event = Event.find(params[:event_id])
    @requirement = Requirement.new(requirement_params)
    if @requirement.save
      flash[:notice] = 'Requirement was successfully created'
      @event.requirements << @requirement
      redirect_to event_requirements_path(@event)
    else
      flash[:notice] = 'Error creating Event'
      render 'new'
    end
  end

  def show
    @event = Event.find(params[:event_id])
  end

  private

  def requirement_params
    params.require(:requirement).permit(:shift_id, :team_id, :mandatory, :optional)
  end
end