class RegistrationsController < ApplicationController
  expose(:conference)
  def create
    current_attendee.register_for(conference)
    redirect_to :back, notice: "Registered for #{conference.name}"
  end

  def destroy
    current_attendee.unregister_from(conference)
    redirect_to :back, notice: "Unregistered for #{conference.name}"
  end
end
