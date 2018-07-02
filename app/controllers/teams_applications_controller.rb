class TeamsApplicationsController < ApplicationController
  load_and_authorize_resource

  def index
    @event = Event.find(params[:event_id])
    @teams_applications = TeamsApplication.where(event_id: @event.id, user_id: current_user )
  end

  def new
    @teams_application = TeamsApplication.new
    @event = Event.find(params[:event_id])
    @teams = Team.where(event_id: @event.id)
  end

  def create
    @event = Event.find(params[:event_id])
    @team_application = TeamsApplication.new(team_application_params)
    if team_application.save
      flash[:notice] = 'Application was successfully created'
      @event.team_applications << @team_application
      @user.team_applications << @team_application
      redirect_to teams_path(@event)
    else
      flash[:notice] = 'Error creating application'
      render application
    end
  end

  private

  def team_application_params
    params.require(:team_application)
          .permit(:first_choice, :second_choice, :third_choice)
  end
end
