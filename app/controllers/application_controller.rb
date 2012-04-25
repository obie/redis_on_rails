class ApplicationController < ActionController::Base
  helper_method :attendee_signed_in?, :current_attendee
  protect_from_forgery

  def current_attendee
    Attendee.find_by_id(session[:attendee_id])
  end

  def current_attendee=(attendee)
    session[:attendee_id] = attendee.to_param
  end

end
