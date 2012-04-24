class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_participant
    Participant.find_by_id(session[:participant_id])
  end

  def current_participant=(name)
    p = Participant.find_by_name(name)
    session[:participant_id] = p.id
  end


end
