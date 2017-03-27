class EventsController < ApplicationController
  before_action :authenticate_user!
  layout 'dashboard'
  include EventsConcern
  
  
  def invite_event
   @event = Event.find(params[:id])
  end

  def uninvite_event
   @event = Event.find(params[:id])
   @invitation = @event.invitations
  end
  
  def show
    @event = EventInstance.find(params[:id]).event
  end

  def new
    @event = current_user.events.build
    @event.event_instances.build
  end

  def create
    @event = current_user.events.build event_params
    @event.save
    get_event_instances
  end

  def edit
    @event = EventInstance.find(params[:id]).event
    @event_instance_id = params[:id]
  end

  def update
    @event = EventInstance.find(params[:id]).event
    @event.update_attributes event_params
    get_event_instances
  end

  def invite_user_form
    @event = Event.find(params[:id])
  end

  def invite_user
    @event = Event.find(params[:id])
    @user = User.find_by(email: params[:user_email])
    if @user.blank?
      @event.errors.add(:base, "A user with the specified email was not found")
    else
      # logic to send invite email to user
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :recurrent, event_instances_attributes: [
      :id, :date, :location
    ])
  end


end