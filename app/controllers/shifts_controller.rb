class ShiftsController < ApplicationController
  load_and_authorize_resource

  def index
    @event = Event.find(params[:event_id])
    @shifts = Shift.where(event_id: @event.id)
  end

  def new
    @event = Event.find(params[:event_id])
    @shift = Shift.new
  end

  def create
    @event = Event.find(params[:event_id])
    @shift = Shift.new(shift_params)
    DateTime.parse(@shift.start_time)
    DateTime.parse(@shift.end_time)
    if @shift.save
      flash[:notice] = 'Shift was successfully created'
      @event.shifts << @shift
      redirect_to event_shifts_path(@event)
    else
      flash[:notice] = 'Error creating Event'
      render 'new'
    end
  end

  private

  def shift_params
    params.require(:shift).permit(:start_date, :end_date)
  end

end