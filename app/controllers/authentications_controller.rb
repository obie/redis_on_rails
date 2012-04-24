class AuthenticationsController < ApplicationController
  def create
    self.current_attendee = Authentication.authenticate(request.env["omniauth.auth"]).attendee
    redirect_to root_url, notice: "Signed in successfully"
  end

  def destroy
    current_attendee.authentications.first.try(:destroy)
    current_attendee = nil
    redirect_to root_url, notice: "Signed out"
  end

  def failure
    url = request.env["omniauth.origin"] || root_url
    redirect_to url, error: "Something went wrong. Please try again later."
  end
end
