class AvailabilitiesController < ApplicationController
  load_and_authorize_resource

  def index
    @event = Event.find(params[:event_id])
    @users = User.all
    @shifts = Shift.where(event_id: @event.id)
    if @current_user.is? :admin
      @availabilities = Availability.joins(:shift).where(shifts: {event_id: @event.id} )
    else
      @availabilities = Availability.joins(:shift).where(availabilities: {user_id: @current_user.id}, shifts: {event_id: @event.id})
    end
  end

  def new
    @event = Event.find(params[:event_id])
    @availability = Availability.new
  end

  def create
    @event = Event.find(params[:event_id])
    @availability = Availability.new(availability_params)
    if @availability.save
      flash[:notice] = 'Availability was successfully saved'
      @current_user.availabilities << @availability
      redirect_to event_shifts_path(@event)
    else
      flash[:notice] = 'Error creating availability'
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