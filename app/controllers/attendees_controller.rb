class AttendeesController < ApplicationController
  expose(:attendee)
  expose(:events) do
    current_attendee ? current_attendee.events(attendee) : []
  end
end
