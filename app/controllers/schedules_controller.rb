class SchedulesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @event = Event.find(params[:event_id])
    schedules = Schedule.where(event_id: @event.id)
    if @current_user.is? :user
      schedules = schedules.select {|s| s[:user_id] == @current_user.id}
    end
    teams = Team.where(event_id: @event.id)
    shifts = Shift.where(event_id: @event.id)
    users = User.all
    @resources = []
    @events = []

    teams.each do |t|
      resource = {id: t[:id], name: t[:title]}
      @resources << resource
    end

    schedules.each_with_index do |s, index|
      shift = shifts.detect {|sh| sh[:id] == s[:shift_id]}
      user = users.detect {|u| u[:id] == s[:user_id]}
      event = { id: index + 1, start: shift[:start_time].strftime('%Y-%m-%d %H:%M:%S'), end: shift[:end_time].strftime('%Y-%m-%d %H:%M:%S'),
               resourceId: s[:team_id],
               title: "#{user[:first_name]} #{user[:last_name]}" }
      unless defined?(user)
        event[:bgColor] = 'red'
      end
      @events << event
    end
    @events.sort_by! {|x| Date.parse x[:start]}

  end

  def admin
    @event = Event.find(params[:event_id])
    @schedule = Schedule.where(event_id: @event.id)
  end

  def edit
    @event = Event.find(params[:event_id])
    @schedule = Schedule.find(params[:id])
  end

  def update
    @event = Event.find(params[:event_id])
    @schedule = Schedule.find(params[:id])
    if @schedule.update(schedule_params)
      flash[:notice] = 'Schedule was successfully updated'
      redirect_to event_schedules_path(@event)
    else
      flash[:notice] = 'Error updating schedule'
      render 'edit'
    end
  end


  def generate
    @event = Event.find(params[:event_id])
    @shifts = Shift.where(event_id: @event.id).order(:start_time)
    @requirements = Requirement.where(event_id: @event.id)
    @availabilities = Availability.joins(:shift).where(shifts: {event_id: @event.id})
    @applications = TeamsApplication.where(event_id: @event.id)

    #Create Schedule array containing all shifts according to their requirements
    @schedule = create_schedule(@shifts, @requirements, @event[:id])

    # creates priority table container the number of required users in a shift and the number of available people
    # then sorts by least requirement and least availability
    priority_table = create_priority(@requirements, @shifts, @availabilities).sort_by {|p| [p[:requirements], p[:availabilities]]}

    # iterate through item in priority table
    priority_table.each_with_index do |p, index|
      # skip if there is no requirement or no availability
      if p[:requirements] != 0 || p[:availabilities] != 0
        # retrieve all schedules at the current shift based on the order of priority table
        priority_schedule = @schedule.select {|s| s[:shift_id] == p[:shift]}
        # retrieve all availabilities at current shift
        availabilities = @availabilities.select {|a| a[:shift_id] == p[:shift]}
        # if availabilities and requirements equals 1, add user to schedule
        if p[:availabilities] == 1 && p[:requirements] == 1
          @schedule[@schedule.index(priority_schedule[0])][:user_id] = availabilities[0][:user_id]
        else
          begin
            priority_schedule.each do |p_s|
              next if match(availabilities, p_s, @applications, @shifts, @schedule, 1) == true
              next if match(availabilities, p_s, @applications, @shifts, @schedule, 2) == true
              next if match(availabilities, p_s, @applications, @shifts, @schedule, 3) == true
            end
          rescue StandardError => e
            puts e
            puts
          end
        end
      end
      puts "done: #{index + 1} / #{priority_table.length}"
    end

    if Schedule.where(event_id: @event.id).blank?
      @schedule.each(&:save)
    end

    redirect_to admin_event_schedules_path(@event)
  end

  private

  # iterate through all availabilities in a shift. Find all users that are available for that shift. passing through
  # every schedule at a given shift, add the user if the current schedule's team corresponds to the level of priority
  # that the user assigned
  def match(availabilities, priority_schedule, all_applications, all_shifts, all_schedules, priority)
    begin
      availabilities.each do |availability|
        unless user_tired(availability[:shift_id], availability[:user_id], all_shifts, all_schedules)

          # find all user team applications at an availability
          team_application = all_applications.select {|app| app[:user_id] == availability[:user_id] && app[:team] == priority_schedule[:team]}
          team_application.each do |application|
            if priority == application[:priority] && all_schedules.detect {|s| s == priority_schedule}[:user_id].blank?
              all_schedules.detect {|s| s == priority_schedule}[:user_id] = availability[:user_id]
              return true
            end
          end
        end
      end
      return false
    rescue StandardError => e
      puts e
    end
  end

  # verifies if user has a shift before or after
  def user_tired(shift_id, user_id, shifts, schedules)
    shift_index = shifts.index {|s| s[:id] == shift_id}
    current_schedules = schedules.select {|s| s[:shift_id] == shifts[shift_index][:id]}
    schedules_before = schedules.select {|s| s[:shift_id] == shifts[shift_index - 1][:id]}
    schedules_after = schedules.select {|s| s[:shift_id] == shifts[shift_index + 1][:id]}
    # return true if a shift is found in the period before, current or next
    if current_schedules.any? {|s| s[:user_id] == user_id} || schedules_before.any? {|s| s[:user_id] == user_id} || schedules_after.any? {|s| s[:user_id] == user_id}
      return true
    else
      return false
    end
  end

  def create_priority(requirements, shifts, availabilities)
    priority_table = []
    shifts.each do |s|
      requirement_shifts = requirements.select {|r| r[:shift_id] == s.id}
      total_requirements = 0
      requirement_shifts.each do |r|
        total_requirements += r.mandatory + r.optional
      end
      availabilities_shift = availabilities.select {|a| a[:shift_id] == s.id}
      total_availabilities = availabilities_shift.count
      priority_table << {shift: s.id, requirements: total_requirements, availabilities: total_availabilities}
    end

    return priority_table
  end

  def create_schedule(shifts, all_requirements, current_event_id)
    schedule = []
    shifts.each do |s|
      requirements = all_requirements.select {|r| r[:shift_id] == s[:id]}
      requirements.each do |r|
        (r.mandatory + r.optional).times do |i|
          schedule << Schedule.new(event_id: current_event_id,
                                   shift_id: s.id,
                                   team_id: r[:team_id],
                                   position: i + 1,
                                   mandatory: (i + 1 <= r.mandatory))
        end
      end
    end
    return schedule
  end

  def schedule_params
    params.require(:schedule).permit(:user_id, :comment)
  end


end