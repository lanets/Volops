class SchedulesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @event = Event.find(params[:event_id])
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
          @schedule << Schedule.new(shift_id: s.id, team_id: r[:team_id], available: false, assigned: false, position: i + 1, mandatory: mandatory)
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
            priority_schedule.each do |s|
              match(availabilities, s, @applications, @shifts, @schedule, 1)
              match(availabilities, s, @applications, @shifts, @schedule, 2)
              match(availabilities, s, @applications, @shifts, @schedule, 3)
              match(availabilities, s, @applications, @shifts, @schedule, 0)
            end
          rescue StandardError => e
            puts e
            puts
          end
        end
      end
      puts "done #{index + 1} / #{priority_table.length}"
      puts
    end

  end

  private


  def match(availabilities, schedule, applications, shifts, schedule_table, priority)
    availabilities.each do |availability|
      # if the user has not done more than 2 consecutive shifts
      tired = user_tired(availability[:shift_id], availability[:user_id], shifts, schedule_table)
      unless tired
        # find all shifts that a user applied to
        user_applications = applications.select {|application| application[:user_id] == availability[:user_id]}
        # find all teams that a user applied to
        team_applications = user_applications.select {|application| application[:team] == schedule[:team]}
        team_applications.each do |application|
          # if the team that the user applied to is the priority that the
          # user has chosen, and that there is no user in the schedule
          if ((application[:priority] == priority && schedule[:user_id].nil?) || priority == 0)
            schedule_table.select {|s| s == schedule}.first[:user_id] = availability[:user_id]
          end
        end
      end
    end
  end

  def get_schedule(index, shifts, schedules)
    return schedules.select {|s| s[:shift_id] == shifts[index - 1][:id]}.first ||= nil
  end

  def user_tired(shift_id, user_id, shifts, schedules)
    tired = false
    shift_index = shifts.index {|s| s.id == shift_id}
    schedule_before = get_schedule(shift_index - 1, shifts, schedules)
    schedule_after = get_schedule(shift_index + 1, shifts, schedules)


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


end