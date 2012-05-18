class Tutorial < ActiveRecord::Base
  #include Redis::Objects
  
  belongs_to :presenter  
  #counter :seats_taken

  # def signup(attendee)
  #   seats_taken.increment do |count|
  #     if count < max_attendees
  #       rdb[:attendee_ids].sadd(attendee.id)
  #       # sadd returns true if successfully added id
  #       # and returns false if already existed, which makes the counter rollback
  #     end
  #     # nil also makes the counter rollback
  #   end
  # end
end
