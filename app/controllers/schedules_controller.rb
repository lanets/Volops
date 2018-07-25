class SchedulesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @event = Event.find(params[:event_id])
    @schedule = Schedule.where(event_id: @event.id)
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

    #Create Schedule array containing all shifts
    @schedule = []
    @shifts.each do |s|
      requirements = @requirements.select {|r| r[:shift_id] == s.id}
      requirements.each do |r|
        (r.mandatory + r.optional).times do |i|
          if (i + 1 <= r.mandatory)
            mandatory = true
          else
            mandatory = false
          end
          @schedule << Schedule.new(event_id: @event.id, shift_id: s.id, team_id: r[:team_id], position: i + 1, mandatory: mandatory)
        end
      end
    end
    # creates priority table container the number of required users in a shift and the number of available people
    priority_table = create_priority(@requirements, @shifts, @availabilities)

    # sort table by least requirement and least availability
    priority_table = priority_table.sort_by {|p| [p[:requirements], p[:availabilities]]}

    # iterate through priority table
    priority_table.each_with_index do |p, index|
      # skip if there is no requirement or no availability
      if p[:requirements] != 0 || p[:availabilities] != 0
        # retrieve all schedules at the current shift
        priority_schedule = @schedule.select {|s| s[:shift_id] == p[:shift]}
        # retrieve all availabilities at current shift
        availabilities = @availabilities.select {|a| a[:shift_id] == p[:shift]}
        # if availabilities and requirements equals 1, add user to schedule
        if p[:availabilities] == 1 && p[:requirements] == 1
          @schedule[@schedule.index(priority_schedule[0])][:user_id] = availabilities[0][:user_id]
        else
          begin
            priority_schedule.each do |p_s|
              match(availabilities, p_s, @applications, @shifts, @schedule, 1)
              match(availabilities, p_s, @applications, @shifts, @schedule, 2)
              match(availabilities, p_s, @applications, @shifts, @schedule, 3)
              #match(availabilities, p_s, @applications, @shifts, @schedule, 0)
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
      redirect_to event_schedules_path(@event)
    end
  end

  private


  def match(availabilities, priority_schedule, all_applications, all_shifts, all_schedules, priority)
    begin
      availabilities.each do |availability|
        unless user_tired(availability[:shift_id], availability[:user_id], all_shifts, all_schedules)

          user_application = all_applications.select {|app| app[:user_id] == availability[:user_id]}
          team_application = user_application.select {|app| app[:team] == priority_schedule[:team]}
          team_application.each do |application|
            if (application[:priority] == priority && all_schedules.select {|s| s == priority_schedule}.first[:user_id].nil?) || priority = 0
              all_schedules.select {|s| s == priority_schedule}.first[:user_id] = availability[:user_id]
              break
            end
          end
        end
      end
    rescue StandardError => e
      puts e
    end
  end

  def get_schedule(index, shifts, schedules)
    return schedules.select {|s| s[:shift_id] == shifts[index - 1][:id]}.first
  end

  def user_tired(shift_id, user_id, shifts, schedules)
    shift_index = shifts.index {|s| s[:id] == shift_id}
    current_schedules = schedules.select {|s| s[:shift_id] == shifts[shift_index][:id]}
    schedules_before = schedules.select {|s| s[:shift_id] == shifts[shift_index - 1][:id]}
    schedules_after = schedules.select {|s| s[:shift_id] == shifts[shift_index + 1][:id]}

    if current_schedules.any? {|s| s[:user_id] == user_id} || schedules_before.any? {|s| s[:user_id] == user_id} || schedules_after.any? {|s| s[:user_id] == user_id}
      return true
    else
      return false
    end


=begin
    tired = false
    if !schedule_before[:user_id].nil? && schedule_before[:user_id].to_s == user_id.to_s
      second_schedule_before = get_schedule(shift_index - 2, shifts, schedules)
      if !second_schedule_before[:user_id].nil? && second_schedule_before[:user_id].to_s == user_id.to_s
        tired = true
      elsif !schedule_after[:user_id].nil? && schedule_after[:user_id].to_s == user_id.to_s
        tired = true
      end
    elsif !schedule_after[:user_id].nil? && schedule_after[:user_id].to_s == user_id.to_s
      second_schedule_after = get_schedule(shift_index + 2, shifts, schedules)
      if !second_schedule_after[:user_id].nil? && second_schedule_after[:user_id].to_s == user_id.to_s
        tired = true
      end
    end
    return tired
=end
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

  def schedule_params
    params.require(:schedule).permit(:user_id, :comment)
  end


end