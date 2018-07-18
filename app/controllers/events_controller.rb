# Event controllers
class EventsController < ApplicationController
  load_and_authorize_resource

  def index
    @events = Event.all
    authorize! :index, @event
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:notice] = 'Event was successfully created'
      redirect_to events_path
    else
      flash[:notice] = 'Error creating Event'
      render 'new'
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      flash[:notice] = 'Event was successfully updated'
      redirect_to event_path(@event)
    else
      flash[:notice] = 'Error updating Event'
      render 'edit'
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :start_date, :end_date)
  end

end