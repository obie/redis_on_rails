ActiveRecord::Base.class_eval do
  # don't want to clutter my example code with attr_protected
  attr_protected

  def rdb
    Nest.new(self.class)[to_param]
  end
end
