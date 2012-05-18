class Talk < ActiveRecord::Base
  include RedisProps

  attr_accessible :conference_id, :talk_name

  props "talk" do
    define :name, default: "Talk Name"
  end
end
