class Conference < ActiveRecord::Base
  include Redis::Objects
  attr_protected
end
