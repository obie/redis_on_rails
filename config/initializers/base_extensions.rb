require 'nest'

ActiveRecord::Base.class_eval do
  # don't want to clutter my example code with attr_protected
  attr_protected

  def rdb
    Nest.new(self.class.name)[to_param]
  end

  def self.rdb
    Nest.new(name)
  end
end
