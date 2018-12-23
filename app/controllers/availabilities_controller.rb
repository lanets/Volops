# frozen_string_literal: true

class AvailabilitiesController < ApplicationController
  load_and_authorize_resource

  def index
    @event = Event.find(params[:event_id])
    shifts = @event.shifts
    if @current_user.is? :admin
      @availabilities = Availability.joins(:shift).where(shifts: { event_id: @event.id }).order(:user_id)
    else
      @availabilities = Availability.joins(:shift).where(availabilities: { user_id: @current_user.id }, shifts: { event_id: @event.id })
    end
    users = User.where(id: @availabilities.map(&:user_id))
    @resources = []
    @events = []
    users.each do |u|
      resource = { id: u[:id], name: u.full_name }
      @resources << resource
    end
    @availabilities.each_with_index do |a, index|
      shift = shifts.detect { |sh| sh[:id] == a[:shift_id] }
      event = { id: index + 1, start: shift[:start_time].strftime('%Y-%m-%d %H:%M:%S'), end: shift[:end_time].strftime('%Y-%m-%d %H:%M:%S'),
                resourceId: a[:user_id], title: "shift ##{index + 1}" }
      @events << event
    end
    @events.sort_by! { |x| Date.parse x[:start] }
  end

  def new
    @event = Event.find(params[:event_id])
    unless Shift.where(event_id: @event.id).any?
      flash[:danger] = 'No shift exists to create availability'
      redirect_back fallback_location: event_shifts_path(@event)
    end

    @availability = Availability.new
  end

  def create
    @event = Event.find(params[:event_id])
    @availability = Availability.new(availability_params)
    if @availability.save
      flash[:success] = 'Availability was successfully saved'
      @current_user.availabilities << @availability
      redirect_to event_shifts_path(@event)
    else
      flash[:danger] = 'Error creating availability'
      render 'new'
    end
  end

  def show
    @event = Event.find(params[:event_id])
  end

  private

  def availability_params
    params.require(:availability).permit(:shift_id, :user_id)
  end
end
