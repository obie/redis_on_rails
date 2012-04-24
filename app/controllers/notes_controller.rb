class NotesController < ApplicationController
  expose(:conference)
  def update
    conference.set_notes_for(current_attendee, params[:notes][:text])
    redirect_to :back, notice: "Added Comment #{conference.name}"
  end
end
