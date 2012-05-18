class Presenter < ActiveRecord::Base
  include Redis::Objects

  has_many :talks
  has_many :tutorials
end
