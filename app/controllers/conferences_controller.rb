class ConferencesController < ApplicationController
  expose(:conference)
  expose(:events) do
    #current_attendee ? current_attendee.events(conference) : (Conference.events)
    Event.where(id: Redis.current.zrange(:events, -50, -1))
    #Event.all
  end

  # def toggle_filter
  #   current_attendee.rdb[:filter][conference] = !current_attendee.rdb[:filter][conference]
  # end
end
