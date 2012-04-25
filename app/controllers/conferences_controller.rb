class ConferencesController < ApplicationController
  expose(:conference)
  expose(:events) do
    current_attendee ? current_attendee.events(conference) : (Conference.events)
  end

  # def toggle_filter
  #   current_attendee.rdb[:filter][conference] = !current_attendee.rdb[:filter][conference]
  # end
end
