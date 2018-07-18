class ShiftsController < ApplicationController
  load_and_authorize_resource

  def index
    @event = Event.find(params[:event_id])
    @shifts = Shift.where(event_id: @event.id)
    @availabilities = Availability.joins(:shift).where(availabilities: {user_id: @current_user.id}, shifts: {event_id: @event.id})
  end

  def new
    @event = Event.find(params[:event_id])
    @shift = Shift.new
  end

  def create
    @event = Event.find(params[:event_id])
    @shift = Shift.new(shift_params)
    DateTime.strptime(@shift.start_time.to_s, '%Y-%m-%d %H:%M')
    DateTime.strptime(@shift.end_time.to_s, '%Y-%m-%d %H:%M')
    if @shift.save
      flash[:notice] = 'Shift was successfully created'
      @event.shifts << @shift
      redirect_to event_shifts_path(@event)
    else
      flash[:notice] = 'Error creating Event'
      render 'new'
    end
  end

  def edit
    @event = Event.find(params[:event_id])
    @shift = Shift.find(params[:id])
  end

  def update
    @event = Event.find(params[:event_id])
    @shift = Shift.find(params[:id])
    if @shift.update(shift_params)
      flash[:notice] = 'Team was successfully updated'
      redirect_to event_shifts_path(@event)
    else
      flash[:notice] = 'Error updating Shift'
      render 'edit'
    end
  end

  private

  def shift_params
    params.require(:shift).permit(:start_time, :end_time)
  end

end