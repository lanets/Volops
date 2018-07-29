class RequirementsController < ApplicationController
  load_and_authorize_resource

  def index
    @event = Event.find(params[:event_id])
    requirements = Requirement.where(event_id: @event.id).joins(:shift, :team).order('shift_id')
    teams = Team.where(event_id: @event.id)
    shifts = Shift.where(event_id: @event.id)

    @events = []
    @resources = []

    teams.each do |t|
      resource = {id: t[:id], name: t[:title]}
      @resources << resource
    end

    requirements.each_with_index do |r, index|
      shift = shifts.detect {|sh| sh[:id] == r[:shift_id]}
      (r.mandatory + r.optional).times do |i|
        event = {id: "#{index + 1}#{i + 1}", start: shift[:start_time].strftime('%Y-%m-%d %H:%M:%S'), end: shift[:end_time].strftime('%Y-%m-%d %H:%M:%S'),
                 resourceId: r[:team_id]
        }
        if (i + 1) <= r.mandatory
          event[:title] = "mandatory ##{i + 1}"
          event[:bgColor] = 'rgb(247, 89, 171)'
        else
          event[:title] = "optional ##{i + 1}"
          event[:bgColor] = 'rgb(250, 158, 149)'
        end
        @events << event
      end
    end
    @events.sort_by! { |x| Date.parse x[:start]}

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