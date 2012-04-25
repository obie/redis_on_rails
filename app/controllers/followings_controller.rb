class FollowingsController < ApplicationController
  expose(:attendee)
  expose(:events) do
    Event.where(id: attendee.following_events)
  end
  
  def create
    current_attendee.follow!(attendee)
    redirect_to :back, notice: "Followed #{attendee.name}"
  end
  
  def destroy
    current_attendee.unfollow!(attendee)
    redirect_to :back, notice: "Unfollowed #{attendee.name}"
  end
end
