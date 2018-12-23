# frozen_string_literal: true

class TeamsController < ApplicationController
  load_and_authorize_resource

  def index
    @event = Event.find(params[:event_id])
    @teams = Team.where(event_id: @event.id)
    @applications = TeamsApplication.where(event_id: @event.id, user_id: @current_user.id)
  end

  def new
    @event = Event.find(params[:event_id])
    @team = Team.new
  end

  def create
    @event = Event.find(params[:event_id])
    @team = Team.new(team_params)
    if @team.save
      flash[:success] = 'Team was successfully created'
      @event.teams << @team
      redirect_to event_teams_path(@event)
    else
      flash[:danger] = 'Error creating Team'
      render 'new'
    end
  end

  def show
    @event = Event.find(params[:event_id])
    @team = Team.find(params[:id])
  end

  def edit
    @event = Event.find(params[:event_id])
    @team = Team.find(params[:id])
  end

  def update
    @event = Event.find(params[:event_id])
    @team = Team.find(params[:id])
    if @team.update(team_params)
      flash[:success] = 'Team was successfully updated'
      redirect_to event_teams_path(@event)
    else
      flash[:danger] = 'Error updating Team'
      render 'edit'
    end
  end

  private

  def team_params
    params.require(:team).permit(:title, :description)
  end
end
