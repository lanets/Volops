# frozen_string_literal: true

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
      flash[:success] = 'Event was successfully created'
      redirect_to events_path
    else
      flash[:danger] = 'Error creating Event'
      render 'new'
    end
  end

  def show
    @event = Event.find(params[:id])
    @schedule_not_created = Schedule.where(event_id: @event).empty?
    @schedules = Schedule.where(event_id: @event, user_id: @current_user.id)
    shifts = Shift.where(id: @schedules.map(&:shift_id))
    @total_hours = 0
    @schedules.each do |s|
      shift = shifts.detect { |sh| sh[:id] == s[:shift_id] }
      @total_hours += ((shift[:end_time] - shift[:start_time]) / 3600).to_i
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      flash[:success] = 'Event was successfully updated'
      redirect_to event_path(@event)
    else
      flash[:danger] = 'Error updating Event'
      render 'edit'
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :start_date, :end_date)
  end
end
